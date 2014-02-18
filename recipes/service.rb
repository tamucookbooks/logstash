case node['logstash']['service_provider']
when 'bluepill'

  include_recipe 'bluepill'

  template '/etc/bluepill/logstash.pill' do
    action :create
    source 'logstash.pill.erb'
    variables(
      logstash: ::File.join(node['logstash']['dir']['bin'],
                            "logstash-#{node['logstash']['version']}-flatjar.jar"),
      config: node['logstash']['dir']['config'],
      log: "#{node['logstash']['dir']['log']}/logstash.log",
      user: node['logstash']['user'],
      group: node['logstash']['group'],
      home: node['logstash']['home']
    )
  end

  bluepill_service 'logstash' do
    action [:enable, :load, :start]
  end
else
  Chef::Log.error("#{node['logstash']['service_provider']} is not currently supported")
end

logrotate_app 'logstash' do
  cookbook 'logrotate'
  path "#{node['logstash']['dir']['log']}/logstash.log"
  frequency 'daily'
  rotate 7
  create "644 #{node['logstash']['user']} #{node['logstash']['group']}"
end
