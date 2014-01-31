action :create do
  config = ::File.join(node['logstash']['dir']['config'],
                       "1_#{new_resource.name}.conf")

  all_opts = new_resource.options || {}
  %w(add_field add_tag remove_field remove_tag type).each do |opt|
    val = new_resource.send(opt)
    all_opts[opt] = val unless val.nil?
  end

  template config do
    source 'logstash_plugin.erb'
    variables(options: all_opts,
              plugin_type: 'filter',
              plugin: new_resource.plugin)
    cookbook 'logstash'
    notifies :restart, 'bluepill_service[logstash]', :delayed
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
