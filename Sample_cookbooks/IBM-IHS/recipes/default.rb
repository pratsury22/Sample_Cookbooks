#
# Cookbook Name:: IBM-IHS
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#
ibm_ihs1 = node['ibm-ihs']['package1']
ibm_ihs2 = node['ibm-ihs']['package2']
ibm_ihs3 = node['ibm-ihs']['package3']
ibm_ihs_extract = node['ibm-ihs']['extract-dir']
ibm_ihs_bin = node['ibm-ihs']['bin']
ibm_im_path = node['ibm-im']['path']
#ibm_ihs_path = node['ibm-ihs']['path']
ibm_ihs_start = node['ibm-ihs']['start']

package "unzip"
package "apr-util"
package "compat-expat1"


directory "#{ibm_ihs_extract}" do
  action :create
  mode '755'
  user 'root'
  group 'root'
end

bash "unzip-ibm-ihs" do
  user 'root'
  code <<-EOH
    unzip #{ibm_ihs1} -d #{ibm_ihs_extract}
    unzip #{ibm_ihs2} -d #{ibm_ihs_extract}
    unzip #{ibm_ihs3} -d #{ibm_ihs_extract}
    EOH
  not_if { ::File.exists?("#{ibm_ihs_extract}/repository.config")}
#	not_if {Dir ["#(ibm_ihs_extract)"]}
end


execute "install-ibm-ihs" do
  command "#{ibm_im_path}/imcl install com.ibm.websphere.IHS.v85 -repositories #{ibm_ihs_extract} -installationDirectory /opt/IBM/HTTPServer -acceptLicense -properties 'user.ihs.httpPort=80,user.ihs.allowNonRootSilentInstall=true' -log /tmp/ihs_install.xml"
  not_if { ::File.exists?("#{ibm_ihs_bin}")}
#	not_if {Dir ["#(ibm_ihs_path)"]}
end

execute "start-ibm-ihs" do
  command "#{ibm_ihs_start}/apachectl -k start"
end
