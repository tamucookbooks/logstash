site :opscode

cookbook 'bluepill'
cookbook 'apache2'
cookbook 'java'
cookbook 'elasticsearch'

group :integration do
  cookbook 'apt'
  cookbook 'yum-epel'
  cookbook 'logstash_test', path: './test/cookbooks/logstash_test'
end

metadata
