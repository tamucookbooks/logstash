name             'logstash'
maintainer       'Texas A&M'
maintainer_email 'yli@tamu.edu'
license          'All rights reserved'
description      'Installs/Configures lib-logstash'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'
supports         'ubuntu', '>= 12.04'
supports         'centos', '>= 6.4'
depends          'bluepill'
depends          'java'
depends          'logrotate'
