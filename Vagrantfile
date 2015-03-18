# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.host_name = 'rails-dev'

  config.omnibus.chef_version = :latest
  config.vm.network :private_network, ip: "33.33.33.10"
  config.vm.boot_timeout = 120
  config.berkshelf.enabled = true
  VAGRANT_JSON = JSON.parse(Pathname(__FILE__).dirname.join('nodes', 'vagrant.json').read)

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["site-cookbooks", "cookbooks"]
    chef.roles_path = "roles"
    chef.data_bags_path = "data_bags"
    chef.json = VAGRANT_JSON
    chef.log_level = :debug

    VAGRANT_JSON['run_list'].each do |recipe|
      chef.add_recipe(recipe)
    end if VAGRANT_JSON['run_list']

    # chef.add_role "rails-development"
    # chef.json = {
    #     :mysql => {
    #       :server_root_password   => '',
    #       :server_debian_password => '',
    #       :server_repl_password   => ''
    #     },
    #   #   "postgresql" => {
    #   #     "password" => {
    #   #       "postgres" => ""
    #   #     }
    #   #   },
    #     rbenv: {
    #     user_installs: [{
    #       user: 'vagrant',
    #       rubies: ["2.1.2"],
    #       global: "2.1.2",
    #       gems: {
    #         "2.1.2" => [
    #           { name: "bundler" }
    #         ]
    #       }
    #     }]
    #   }
  #   :nginx => {
  #   :dir => "/etc/nginx",
  #   :init_style => "init",
  #   :source => {
  #       :modules => [
  #           "nginx::passenger"
  #           ]
  #       },
  #     :passenger => {
  #           :ruby => "/home/vagrant/.rbenv/shims/ruby",
  #           :root => "/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini"
  #       }
  # },
      }
  end
end
