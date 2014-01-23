service_provider = nil

case node['logstash']['service_provider']
when 'bluepill'

  include_recipe 'bluepill'

  template '/etc/bluepill/logstash.pill' do
    action :create
    source 'logstash.pill.erb'
    variables(
      :logstash => ::File.join(node['logstash']['dir']['bin'],
                               "logstash-#{}-flatjar.jar"),
      :config => ::File.join(node['logstash']['dir']['config'],
                             "logstash.conf"),
      :home => node['logstash']['home']
    )
  end

  bluepill_service 'logstash' do
     action [:enable, :load, :start]
  end
else
  Chef::Log.error("#{node['logstash']['service_provider']} is not currently supported")
end
