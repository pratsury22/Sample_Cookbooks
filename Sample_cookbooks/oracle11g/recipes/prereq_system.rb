#
# Cookbook Name:: oracle11g
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
oracleasmlib = node['oracle11g']['oracleasmlib']
oracleasm_support = node['oracle11g']['oracleasm-support']

directory "/oracle"

# Create SWAP 
swap_file '/oracle/swap' do
  size node['oracle11g']['swapsize']
  persist true
end

# Install Pre-req Packages

if node['platform_version'].to_f >= 7
  %w(openssh-server openssh-clients binutils compat-libcap1 gcc gcc-c++ glibc glibc-devel ksh libaio libaio-devel libgcc libstdc++ libstdc++-devel libXi libXtst unixODBC unixODBC-devel elfutils-libelf-devel).each do |pkg|
    package pkg do
    end
  end
  %w(glibc glibc-devel libaio libaio-devel libgcc libstdc++ libstdc++-devel libXi libXtst unixODBC unixODBC-devel).each do |pkg32b|
    package pkg32b do
      arch "i686"
    end
  end
else
  %w(openssh-server openssh-clients binutils compat-libcap1 compat-libstdc++-33.x86_64 gcc gcc-c++ glibc glibc-devel libgcc libstdc++ libstdc++-devel libaio libaio-devel make sysstat unixODBC unixODBC-devel elfutils-libelf-devel).each do |pkg|
    package pkg do
    end
  end
  %w(compat-libstdc++-33 glibc glibc-devel libgcc libstdc++ libstdc++-devel libaio libaio-devel unixODBC unixODBC-devel).each do |pkg32b|
    package pkg32b do
      arch "i686"
    end
  end
  package 'oracleasmlib' do
    source "#{oracleasmlib}"
    action :install
  end
  package 'oracleasm-support' do
    source "#{oracleasm_support}"
    action :install
  end
end

# Create Directory structure.
directory '/oracle' do
  mode '755'
  user 'oracle'
end

%w(grid database).each do |directory|
  directory "/oracle/#{directory}" do
    mode '755'
    user 'oracle'
  end
end

%w(grid oraInventory).each do |directory|
  directory "/oracle/grid/#{directory}" do
    mode '755'
    user 'oracle'
    group 'grid'
  end
end

%w(oracle).each do |directory|
  directory "/oracle/database/#{directory}" do
    mode '755'
    user 'oracle'
    group 'oinstall'
  end
end

%w(oradata fra).each do |directory|
  directory "/oracle/database/#{directory}" do
    mode '755'
    user 'oracle'
    group 'oinstall'
  end
end


directory "/oracle/grid/grid/product/11.2.0/grid" do
  mode '755'
  user 'oracle'
  recursive true
end

directory "/oracle/database/oracle/product/11.2.0/dbhome_1" do
  mode '755'
  user 'oracle'
  recursive true
end

directory "/tmp/oracle" do
  mode '755'
  user 'oracle'
  group 'oinstall'
end

bash 'set_permission' do
  code <<-EOH
    chmod 644 /etc/security/limits.conf
    chmod 644 /etc/sysctl.conf
  EOH
end
