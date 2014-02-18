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
