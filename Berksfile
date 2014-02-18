site :opscode

cookbook 'bluepill'
cookbook 'java'
cookbook 'logrotate'

group :integration do
  cookbook 'apt'
  cookbook 'yum-epel'
  cookbook 'logstash_test', path: './test/cookbooks/logstash_test'
end

metadata
