#
# Cookbook Name:: oracle11g
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe('oracle11g::prereq_users')
include_recipe('oracle11g::prereq_system')
include_recipe('oracle11g::prereq_kernel')
