action :create do
  temp = 'logstash_int.erb'

  config = ::File.join(node['logstash']['dir']['config'],
                       "0_#{new_resource.name}.conf")

  all_opts = new_resource.options
  all_opts['tags'] = new_resource.tags.nil?
  all_opts['debug'] = new_resource.debug
  all_opts['type'] = new_resource.type

  template config do
    source 'logstash_int.erb'
    variables(all_opts)
  end
end

action :remove do

end
