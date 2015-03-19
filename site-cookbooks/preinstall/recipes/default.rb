#
# Cookbook Name:: preinstall
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
node.default[:packages].each do |p|
  package p do
    action :install
  end
end
# Deployer user, sudoer and with known RSA keys
user_account 'deploy' do
  create_group true
end
group "sudo" do
  action :modify
  members "deploy"
  append true
end
cookbook_file "id_rsa" do
  source "id_rsa"
  path "/home/deploy/.ssh/id_rsa"
  group "deploy"
  owner "deploy"
  mode 0600
  action :create_if_missing
end
cookbook_file "id_rsa.pub" do
  source "id_rsa.pub"
  path "/home/deploy/.ssh/id_rsa.pub"
  group "deploy"
  owner "deploy"
  mode 0644
  action :create_if_missing
end

# Allow sudo command without password for sudoers
cookbook_file "sudo_without_password" do
  source "sudo_without_password"
  path "/etc/sudoers.d/sudo_without_password"
  group "root"
  owner "root"
  mode 0440
  action :create_if_missing
end

# Authorize yourself to connect to server
cookbook_file "authorized_keys" do
  source "authorized_keys"
  path "/home/deploy/.ssh/authorized_keys"
  group "deploy"
  owner "deploy"
  mode 0600
  action :create
end

# Add Github as known host
ssh_known_hosts_entry 'github.com'

include_recipe "git"
# for each listed user
node.default[:users].each do |user_hash|
  if user_hash[:home]
    home_directory = user_hash[:home]
  else
    home_directory = `cat /etc/passwd | grep "^#{user_hash[:login]}:" | cut -d ":" -f6`.chop
  end

  git "#{home_directory}/.oh-my-zsh" do
    repository node.default[:repository]
    user user_hash[:login]
    reference "master"
    action :sync
  end

  template "#{home_directory}/.zshrc" do
    source "zshrc.erb"
    owner user_hash[:login]
    mode "644"
    action :create_if_missing
    variables({
      :user => user_hash[:login],
      :theme => user_hash[:theme] || 'robbyrussell',
      :case_sensitive => user_hash[:case_sensitive] || false,
      :plugins => user_hash[:plugins] || %w(git)
      :secret_key => node.default[:secret_key]
    })
  end

  user user_hash[:login] do
    action :modify
    shell '/bin/zsh'
  end

  if platform?("debian", "ubuntu")
    execute "source /etc/profile to all zshrc" do
      command "echo 'source /etc/profile' >> /etc/zsh/zprofile"
      not_if "grep 'source /etc/profile' /etc/zsh/zprofile"
    end
  end

end
