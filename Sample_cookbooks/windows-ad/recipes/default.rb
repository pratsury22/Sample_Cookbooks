#
# Cookbook Name:: windows-ad
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Installing Windows AD

#powershell_script 'Set_execution_policy' do
#  action :run
#  code <<-EOH
#    Set-ExecutionPolicy remotesigned -f
#  EOH
#end

powershell_script 'Install_Windows_AD' do
  action :run
  code <<-EOH
    Install-windowsfeature AD-domain-services
    Import-Module ADDSDeployment
  EOH
end

#Installing Forest

powershell_script 'Install_ADDS_Forest' do
  action :run
  code <<-EOH
    Install-ADDSForest -CreateDnsDelegation:$false  -DatabasePath "C:\Windows\NTDS"  -DomainMode "Win2012R2"  -DomainName "ctstest1.com"  -DomainNetbiosName "ctstest" -ForestMode "Win2012R2"  -InstallDns:$true  -LogPath "C:\Windows\NTDS"  -NoRebootOnCompletion:$true  -SysvolPath "C:\Windows\SYSVOL"  -Force:$true -safemodeadministratorpassword (convertto-securestring "Password1" -asplaintext -force)
  EOH
end

reboot "windows_ad_require_reboot" do
  action :request_reboot
  reason "Windows_AD require a restart"
  delay_mins 2
end
