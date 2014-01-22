require 'uri'

include_recipe 'bluepill'
package "java-1.7.0-openjdk" do
  not_if { File.exists? "/usr/bin/java" }
end

lsversion = node['logstash']['version']
esversion = node['logstash']['elasticsearch']['version']
lsbase = node['logstash']['lsbaseuri']
esbase = node['logstash']['esbaseuri']
esfile = "elasticsearch-#{esversion}.noarch.rpm"
lsfile = "logstash-#{lsversion}-flatjar.jar"
lsexec = "#{node['logstash']['execdir']}/#{lsfile}"

lsfetch = URI::join(lsbase, lsfile).to_s
esfetch = URI::join(esbase, esfile).to_s

directory '/etc/logstash'

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

remote_file lsexec do
  source lsfetch
end

template "/etc/logstash/agent.conf" do
  source "agent.conf.erb"
  variables(
    :logfiles => node['log'],
    :logserver => node['logstash']['server'],
    :loginterval => node['logstash']['interval'],
  )
end

template "#{node['bluepill']['conf_dir']}/logstash-agent.pill" do
  source "logstash-agent.pill.erb"
  variables(
    :logstash => lsexec,
    :agent => '/etc/logstash/agent.conf',
    :home => node['logstash']['home'],
  )
end

bluepill_service 'logstash-agent' do
  supports :restart => true
  action [:enable, :load, :start]
  subscribes :restart, 'template[/etc/logstash/agent.conf]', :immediately
end
