name             'logstash'
maintainer       'Texas A&M'
maintainer_email 'yli@tamu.edu'
license          'MIT'
description      'Installs/Configures lib-logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
%w(ubuntu centos suse).each do |os|
  supports os
end

%w(java logrotate ark bluepill).each do |dep|
  depends dep
end
