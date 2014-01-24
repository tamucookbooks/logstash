action :create do
  temp = 'logstash_int.erb'

  config = ::File.join(node['logstash']['dir']['config'],
                       "0_#{new_resource.name}.conf")

  all_opts = new_resource.options || {}
  all_opts['tags'] = new_resource.tags unless new_resource.tags.nil?
  all_opts['debug'] = 'true' if new_resource.debug
  all_opts['type'] = new_resource.type unless new_resource.type.nil?

  template config do
    source 'logstash_input.erb'
    variables(:options => all_opts,
              :plugin => new_resource.plugin)
    cookbook 'logstash'
    notifies :restart, "bluepill_service[logstash]", :delayed
  end
end

action :remove do

end
