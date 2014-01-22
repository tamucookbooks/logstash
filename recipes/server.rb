#
# Cookbook Name:: lib-logstash
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'bluepill'
include_recipe 'apache2'
include_recipe 'apache2::mod_ldap'
include_recipe 'apache2::mod_authnz_ldap'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'

package "java-1.7.0-openjdk"


lsversion = node['logstash']['version']
esversion = node['logstash']['elasticsearch']['version']
kbversion = node['logstash']['kibana']['version']
lsbase = node['logstash']['lsbaseuri']
esbase = node['logstash']['esbaseuri']
kbbase = node['logstash']['kbbaseuri']
esfile = "elasticsearch-#{esversion}.noarch.rpm"
lsfile = "logstash-#{lsversion}-flatjar.jar"
kbfile = "kibana-#{kbversion}.tar.gz"
lsexec = "#{node['logstash']['execdir']}/#{lsfile}"

kibanadir = node['logstash']['kibana']['dir']

lsfetch = URI::join(lsbase, lsfile).to_s
esfetch = URI::join(esbase, esfile).to_s
kbfetch = URI::join(kbbase, kbfile).to_s

node.default['apache']['listen_ports'] = ["80", "9000"]

remote_file "/tmp/#{esfile}" do
  source esfetch
end

rpm_package "/tmp/#{esfile}" do
  not_if { File.exists? "/usr/share/elasticsearch/bin/elasticsearch" }
  action :install
end

cookbook_file '/etc/elasticsearch/elasticsearch.yml' do 
  source 'elasticsearch.yml'
end

service "elasticsearch" do
  supports :restart => true, :status => true, :reload => true
  action [:enable, :start]
  subscribes :restart, 'cookbook_file[/etc/elasticsearch/elasticsearch.yml]', :immediately
end

package "redis"

cookbook_file '/etc/redis.conf' do
  source 'redis.conf'
end

service "redis" do
  action [:enable, :start]
  subscribes :restart, 'cookbook_file[/etc/redis.conf]', :immediately
end

remote_file lsexec do
  source lsfetch
end

directory '/etc/logstash'

cookbook_file '/etc/logstash/indexer.conf' do
  source 'indexer.conf'
end

group node['logstash']['group'] do
  gid node['logstash']['gid']
  system true
end

user node['logstash']['user'] do
  uid node['logstash']['uid']
  gid node['logstash']['group']
  system true
  home node['logstash']['home']
  supports :manage_home => true
end

template "#{node['bluepill']['conf_dir']}/logstash-indexer.pill" do
  source "logstash-indexer.pill.erb"
  variables(
    :logstash_user => node['logstash']['user'],
    :logstash_group => node['logstash']['group'],
    :logstash => lsexec,
    :indexer => '/etc/logstash/indexer.conf',
    :pidfile => "#{node['logstash']['home']}/indexer.pid",
    :home => node['logstash']['home']
  )
end

bluepill_service 'logstash-indexer' do
  supports :restart => true
  action [:enable, :load, :start]
  subscribes :restart, "template[#{node['bluepill']['conf_dir']}/logstash-indexer.pill]", :immediately
end

template "#{node['apache']['dir']}/sites-available/logstash" do
  source "logstash.erb"
  variables(
    :ldapurl => node['logstash']['ldap']['ldapurl'],
    :ldapbinddn => node['logstash']['ldap']['ldapbinddn'],
    :ldapbindpass => node['logstash']['ldap']['ldapbindpass'],
  )
end

# cookbook_file '/etc/httpd/libraryca.cert' do
#   source 'libraryca.cert'
# end

apache_site 'logstash'

remote_file "/tmp/#{kbfile}" do
  not_if { File.exists? "#{node['logstash']['kibana']['dir']}/app/app.js" }
  source kbfetch
  owner node['apache']['user']
  group node['apache']['group']
end

directory node['logstash']['kibana']['dir'] do
  owner node['apache']['user']
  group node['apache']['group']
end

execute "untar-kibana" do
  not_if { File.exists? "#{node['logstash']['kibana']['dir']}/app/app.js" }
  command "tar -xf /tmp/#{kbfile} -C #{node['logstash']['kibana']['dir']} --strip-components=1"
  user node['apache']['user']
  group node['apache']['group']
end

template "#{kibanadir}/config.js" do
  source "config.js.erb"
  variables(
    :host => node['logstash']['name'],
  )
end

file "#{kibanadir}/app/dashboards/default.json" do
  action :delete
end

link "#{kibanadir}/app/dashboards/default.json" do
  to "#{kibanadir}/app/dashboards/logstash.json"
end

service "httpd" do
  supports :restart => true, :status => true, :reload => true
  action [:start, :enable]
  subscribes :restart, "template[#{node['apache']['dir']}/sites-available/logstash]", :delayed
end

