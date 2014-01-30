#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright 2013, Texas A&M
#
# All rights reserved - Do Not Redistribute
#

require 'uri'

node.set['java']['jdk_version'] = '7'

include_recipe 'java'

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

node['logstash']['dir'].each_value do |dir|
  directory dir do
    action :create
    owner node['logstash']['user']
    group node['logstash']['group']
  end
end

logstash_bin = "logstash-#{node['logstash']['version']}-flatjar.jar"
logstash_uri = URI::join(node['logstash']['uri'],
                         logstash_bin)

remote_file ::File.join(node['logstash']['dir']['bin'], logstash_bin) do
  source logstash_uri.to_s
end

include_recipe 'logstash::service'
