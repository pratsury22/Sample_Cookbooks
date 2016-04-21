#
# Cookbook Name:: oracle11g
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

oracle_inv_group = node['oracle11g']['inventory_group']
oracle_password = node['oracle11g']['oracle_password']
grid_password = node['oracle11g']['grid_password']

user 'oracle' do
  supports :manage_home => true
  comment 'Oracle User'
  home '/home/oracle'
  shell '/bin/bash'
  password '#{oracle_password}'
end

user 'grid' do
  supports :manage_home => true
  comment 'Grid User'
  home '/home/grid'
  shell '/bin/bash'
  password '#{grid_password}'
end

group "#{oracle_inv_group}" do
  action :create
  members ['oracle','grid']
  append true
end

cookbook_file '/home/oracle/oracleuserenv.sh' do
  source 'oracleuserenv.sh'
  mode '700'
  user 'oracle'
end

execute 'run_env' do
  command "/bin/bash /home/oracle/oracleuserenv.sh"
end
