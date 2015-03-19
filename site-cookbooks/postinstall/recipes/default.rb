#
# Cookbook Name:: postinstall
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

# include_recipe "nginx"

  package 'apt-transport-https'

  apt_repository 'phusionpassenger' do
    uri 'https://oss-binaries.phusionpassenger.com/apt/passenger'
    distribution node['lsb']['codename']
    components %w(main)
    deb_src true
    keyserver 'keyserver.ubuntu.com'
    key '561F9B9CAC40B2F7'
  end
  package 'nginx-full'
  package 'passenger'

# link nginx_var_log_path do
#   to File.join(node['nginx']['path'], 'logs')
# end

directory File.join(node['nginx']['path'], 'sites-available') do
  mode        '0755'
end

directory File.join(node['nginx']['path'], 'sites-enabled') do
  mode        '0755'
end
nginx_conf = File.join(node['nginx']['path'], 'nginx.conf')

template nginx_conf do
  owner       'root'
  group       'root'
  mode        '0644'
  source      'nginx.conf.erb'
  variables   :passenger_root => '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini',
              :passenger_ruby => '/home/#{node["user"]["name"]}/.rbenv/shims/ruby'
  notifies    :reload, 'service[nginx]'
end

# Create practicingruby site config
template "#{node["nginx"]["path"]}/sites-available/#{node["app"]["name"]}" do
  source "nginx_site.erb"
  owner  "root"
  group  "root"
  mode   "0644"
end

# Enable practicingruby site
# nginx_site "#{node["app"]["name"]}" do
#   enable true
# end

service 'nginx' do
  supports    :status => true,
              :restart => true,
              :reload => true
  action      [:enable, :start]
end

postgresql_connection_info = {:host => "127.0.0.1",
                              # :port => node['postgresql']['config']['port'],
                              :username => 'postgres',
                              :password => node['postgresql']['password']['postgres']}
# create a postgresql user but grant no privileges
postgresql_database_user node["user"]["name"] do
  connection postgresql_connection_info
  password node['app']['password']
  action [:create]
end
postgresql_database node['app']['name'] do
  connection postgresql_connection_info
  action :create
end
# grant all privileges on all tables in foo db
postgresql_database_user node["user"]["name"] do
  connection postgresql_connection_info
  database_name node['app']['name']
  privileges [:all]
  action :grant
end
