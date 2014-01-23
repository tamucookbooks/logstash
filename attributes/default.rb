default['logstash']['dir']['config'] = '/etc/logstash'
default['logstash']['dir']['bin'] = '/opt/logstash'
default['logstash']['version'] = '1.2.2'
default['logstash']['service_provider'] = 'bluepill'
default['logstash']['user'] = 'logstash'
default['logstash']['uid'] = 357
default['logstash']['group'] = 'logstash'
default['logstash']['gid'] = 357
default['logstash']['home'] = '/var/lib/logstash'

default['logstash']['version'] = '1.2.2'
default['logstash']['uri'] = "https://download.elasticsearch.org/logstash/logstash/"


default['logstash']['elasticsearch']['version'] = '0.90.3'
default['logstash']['kibana']['version'] = '3.0.0milestone4'
default['logstash']['kibana']['dir'] = '/var/www/html'
default['logstash']['esbaseuri'] = "https://download.elasticsearch.org/elasticsearch/elasticsearch/"
default['logstash']['kbbaseuri'] = "https://download.elasticsearch.org/kibana/kibana/"

default['logstash']['server'] = 'logstash.l'
default['logstash']['name'] = 'logstash.library.tamu.edu'
default['logstash']['interval'] = 5

default['logstash']['ldap']['ldapurl'] = 'ldaps://ldap.server/DC=tamu,DC=edu?sAMAccountName?sub?'
default['logstash']['ldap']['ldapbinddn'] = 'CN=proxy,OU=ServiceAccounts,DC=tamu,DC=edu'
default['logstash']['ldap']['ldapbindpass'] = 'ldapbindpassword'
