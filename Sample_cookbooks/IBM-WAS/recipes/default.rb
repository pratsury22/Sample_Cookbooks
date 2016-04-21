#
# Cookbook Name:: IBM-WAS
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
ibm_was1 = node['ibm-was']['package1']
ibm_was2 = node['ibm-was']['package2']
ibm_was3 = node['ibm-was']['package3']
ibm_was_extract = node['ibm-was']['extract-dir']
ibm_was_bin = node['ibm-was']['bin']
ibm_im_path = node['ibm-im']['path']
#ibm_was_path = node['ibm-was']['path']
ibm_was_app = node['ibm-was']['app']
ibm_ihs_extract = node['ibm-ihs']['extract-dir']
ibm_was_start = node['ibm-was']['start']
ibm_was_plugin = node['ibm-was']['plugin']

yum_package "glibc" do
  arch "i686"
end

yum_package "libgcc" do
  arch "i686"
end

package "unzip"

directory "#{ibm_was_extract}" do
  action :create
  mode '755'
  user 'root'
  group 'root'
end

bash "unzip-ibm-was" do
  user 'root'
  code <<-EOH
    unzip #{ibm_was1} -d #{ibm_was_extract}
    unzip #{ibm_was2} -d #{ibm_was_extract}
    unzip #{ibm_was3} -d #{ibm_was_extract}
  EOH
  not_if { ::File.exists?("#{ibm_was_extract}/repository.config")}
#	not_if {Dir ["#(ibm_was_extract)"]}
end

execute "install-ibm-was" do
  command "#{ibm_im_path}/imcl install com.ibm.websphere.ND.v85 -repositories #{ibm_was_extract} -installationDirectory /opt/IBM/WebSphere/AppServer -sharedResourcesDirectory /opt/IBM/IMShared -acceptLicense -showProgress -log /tmp/was_install.xml"
  not_if { ::File.exists?("#{ibm_was_bin}")}
#       not_if {Dir ["#(ibm_was_path)"]}
end

execute "create-app-profile" do
  command "#{ibm_was_app}/manageprofiles.sh -create -profileName AppSrv01 -profilePath /opt/profiles/AppSrv01 -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/default -cellName TestCell01 -nodeName TestNode01"
end

include_recipe('IBM-IHS::default')

execute "install-ibm-was-plugin" do
  command "#{ibm_im_path}/imcl install com.ibm.websphere.PLG.v85 -repositories #{ibm_ihs_extract} -installationDirectory /opt/IBM/Plugins -acceptLicense -showProgress  -log /tmp/plg_install.xml"
end

execute "install-im-was-toolbox" do
  command "#{ibm_im_path}/imcl install com.ibm.websphere.WCT.v85 -repositories #{ibm_ihs_extract} -acceptLicense -installationDirectory /opt/IBM/WebSphere/Toolbox -showProgress -log /tmp/wct_install.xml"
end

execute "configure-was-plugin" do
  command "#{ibm_was_plugin}/wctcmd.sh -tool pct -defLocName webserver1 -defLocPathname /opt/IBM/Plugins -configType=local -wasExistingLocation=/opt/IBM/WebSphere/AppServer -profileName=/opt/profiles/AppSrv01 -webServerConfigFile1=/opt/IBM/HTTPServer/conf/httpd.conf -webServerDefinition=webserver1 -webServerHostName=localhost -webServerPortNumber=80 -webServerSelected=ihs"
end

execute "start-ibm-was" do
  command "#{ibm_was_start}/startServer.sh server1"
end
