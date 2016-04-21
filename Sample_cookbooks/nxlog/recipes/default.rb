#
# Cookbook Name:: nxlog
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

# User Account Control: Run all commands in Non-Admin Approval Mode

registry_key "HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System" do
key "HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System"
values [{
    :name => "EnableLUA",
    :type => :dword,
    :data => 0
  }]
  only_if { registry_key_exists?("HKEY_LOCAL_MACHINE\\Software\\Microsoft\\Windows\\CurrentVersion\\Policies\\System", :machine) }
  action :create
end

Chef::Log.info("Rebooting vm")

reboot "nxlog_vm_requires_reboot" do
  action :reboot_now
  reason "nxlog vm require a restart"
  delay_mins 1
end
