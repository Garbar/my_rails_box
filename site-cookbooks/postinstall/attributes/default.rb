# default['nginx']['passenger']['version'] = '4.0.8'
 default['nginx']['user']['name']         = 'www-data'
# default['nginx']['user']['group']        = 'nogroup'
# default['nginx']['path']                 = '/opt/nginx'
# default['nginx']['version']              = '1.3.15'

default['nginx']['conf']['worker_processes']   = 4
default['nginx']['conf']['access_log']         = File.join('logs', 'access.log main')
default['nginx']['conf']['error_log']          = File.join('logs', 'error.log notice')
