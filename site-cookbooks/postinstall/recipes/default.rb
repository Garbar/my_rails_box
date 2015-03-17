#
# Cookbook Name:: postinstall
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
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

link nginx_var_log_path do
  to          File.join(node['nginx']['path'], 'logs')
end

directory File.join(node['nginx']['path'], 'sites-available') do
  mode        '0755'
end

directory File.join(node['nginx']['path'], 'sites-enabled') do
  mode        '0755'
end
nginx_conf = File.join(node['nginx']['path'], 'conf', 'nginx.conf')

template nginx_conf do
  owner       'root'
  group       'root'
  mode        '0644'
  source      'nginx.conf.erb'
  variables   :passenger_root => '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini',
              :passenger_ruby => '/home/vagrant/.rbenv/shims/ruby'
  notifies    :reload, 'service[nginx]'
end
