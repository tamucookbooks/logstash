include_recipe 'logstash'

logstash_input 'test_input' do
  plugin 'tcp'
  type 'syslog'
  options(port: '80')
end

logstash_input 'stdin' do
  plugin 'stdin'
end

logstash_filter 'sample_filter' do
  plugin 'syslog_pri'
  add_tag 'syslog'
end

logstash_filter 'grok_filter' do
  plugin 'grok'
  type 'syslog'
  options(pattern: '%{SYSLOGBASE}')
  add_field %w(recieved_from %{@source_host})
end

logstash_output 'stdout' do
  plugin 'stdout'
end
