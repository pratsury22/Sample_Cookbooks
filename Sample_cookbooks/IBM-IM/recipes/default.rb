#
# Cookbook Name:: IBM-IM
# Recipe:: default
#
# Copyright 2015, Cognizant
#
# All rights reserved - Do Not Redistribute
#

ibm_im = node['ibm-im']['package']
ibm_im_extract = node['ibm-im']['extract-dir']
ibm_im_bin = node['ibm-im']['bin']

package "unzip"

directory "#{ibm_im_extract}" do
  action :create
  mode '755'
  user 'root'
  group 'root'
end

execute "unzip_ibm_im" do
 command "unzip #{ibm_im} -d #{ibm_im_extract}"
 not_if { ::File.exists?("#{ibm_im_extract}/installc")}
end

execute "install_ibm-im" do
  command "#{ibm_im_extract}/installc -acceptLicense -log /tmp/im_install.xml"
  not_if { ::File.exists?("#{ibm_im_bin}")} 
end
