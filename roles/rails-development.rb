name "rails-development"
description "setup for ruby on rails core development"
run_list(
  "recipe[apt]",
  "recipe[user]",
  "recipe[ssh_known_hosts]",
  "recipe[preinstall]",
  "recipe[nodejs]",
  "recipe[ruby_build]",
  "recipe[rbenv]",
  # "recipe[rbenv::vagrant]",
  # "recipe[nginx::passenger]",
  # "recipe[nginx::source]",
  "recipe[mysql::server]",
  "recipe[mysql::client]",
  "recipe[postinstall]"
)
