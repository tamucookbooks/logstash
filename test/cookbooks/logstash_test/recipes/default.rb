include_recipe 'logstash'

logstash_input 'test_input' do
  plugin 'tcp'
  type 'syslog'
  options(:port => '80')
end
