action :create do
  config = ::File.join(node['logstash']['dir']['config'],
                       "2_#{new_resource.name}.conf")

  all_opts = new_resource.options || {}

  template config do
    source 'logstash_plugin.erb'
    variables(options: all_opts,
              plugin_type: 'output',
              plugin: new_resource.plugin)
    cookbook 'logstash'
    if node['logstash']['service_provider'] == 'bluepill'
      notifies :restart, 'bluepill_service[logstash]', :delayed
    else
      notifies :restart, 'service[logstash]', :delayed
    end
  end
end

action :remove do
  config = ::File.join(node['logstash']['dir']['config'],
                       "1_#{new_resource.name}.conf")

  if ::File.exist? config
    file config do
      action :delete
    end
    new_resource.updated_by_last_action(false)
  else
    new_resource.updated_by_last_action(false)
  end
end
