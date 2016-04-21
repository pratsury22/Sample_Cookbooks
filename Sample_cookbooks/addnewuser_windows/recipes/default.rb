#
# Cookbook Name:: addnewuser_windows
# Recipe:: default
#
# Copyright 2015, Cognizant
#
# All rights reserved - Do Not Redistribute
#

powershell_script 'Addnewuser' do
  action :run
  code <<-EOH
    $user="ctsadmin"
    $password="G7ikolj8"
    net user /add $user $password
    net localgroup Administrators /add $user
  EOH
end

reboot "windows_require_reboot" do
  action :request_reboot
  reason "Windows require a restart"
  delay_mins 2
end
