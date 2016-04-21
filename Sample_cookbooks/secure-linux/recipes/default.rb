#
# Cookbook Name:: secure-linux
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe('secure-linux::packages')
include_recipe('secure-linux::init_umask')
include_recipe('secure-linux::passalgo')
include_recipe('secure-linux::login_defs')
include_recipe('secure-linux::users')
include_recipe('secure-linux::file_access')
include_recipe('secure-linux::patch')
include_recipe('secure-linux::inittab')
include_recipe('secure-linux::pam')
include_recipe('secure-linux::auditd')
include_recipe('secure-linux::suid-sgid')
include_recipe('secure-linux::aide')
#include_recipe('secure-linux::sysctl')
include_recipe('secure-linux::ssh')
include_recipe('secure-linux::sudo')
