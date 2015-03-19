default['user']['name']    = 'deploy'
default['app']['name']    = 'rails20'
default['domain']['name']    = ''
default['domain']['ip']    = '128.199.62.181'

default['nginx']['path']   = '/etc/nginx'
default['nginx']['conf']['worker_processes']   = 2
default['app']['password'] = 'super_secret'

default["nginx"]["dir"]        = "/etc/nginx"
default["nginx"]["log_dir"]    = "/var/log/nginx"
default["nginx"]["user"]       = "www-data"

default["nginx"]["passenger_enable"]         = true
default["nginx"]["passenger_max_pool_size"]  = 6
default["nginx"]["passenger_pool_idle_time"] = 300

default["nginx"]["skip_default_site"]  = false

