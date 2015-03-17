name "rails-development"
description "setup for ruby on rails core development"
run_list(
  "recipe[apt]",
  "recipe[preinstall]",
  "recipe[nodejs]",
  "recipe[ruby_build]",
  "recipe[rbenv::user]",
  "recipe[rbenv::vagrant]",
  # "recipe[nginx::passenger]",
  # "recipe[nginx::source]",
  "recipe[mysql::server]",
  "recipe[mysql::client]"
  "recipe[postinstall]"
)
