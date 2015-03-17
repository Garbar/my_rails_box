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