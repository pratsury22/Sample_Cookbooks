user = Chef::DataBagItem.load("management", "users")
admin_user = user['admin_user']
backup_user  = user['backup_user']
monitor_user = user['monitor_user']
admin_ssh_pubkey   = user['admin_ssh_pubkey']
backup_ssh_pubkey  = user['backup_ssh_pubkey']
monitor_ssh_pubkey = user['monitor_ssh_pubkey']


%w(#{admin_user} #{backup_user} #{monitor_user}).each do |username|
  user username do
    supports :manage_home => true
    comment 'Cognizant Management User'
    password '$1$b7VbWIkD$y6GFiGQsMCPc6uZ7u/Qy3.'
    shell '/bin/bash'
    action :create
  end
end

%w(#{admin_user} #{backup_user} #{monitor_user}).each do |username|
  directory "/home/#{username}/.ssh" do
    owner username
    group username
  end
end

file "/home/#{admin_user}/.ssh/authorized_keys" do
  owner admin_user
  mode  0600
  content "#{admin_ssh_pubkey} #{admin_user}"
  not_if { ::File.exists?("/home/#{admin_user}/.ssh/authorized_keys")}
end

file "/home/#{backup_user}/.ssh/authorized_keys" do
  owner backup_user
  mode  0600
  content "#{backup_ssh_pubkey} #{backup_user}"
  not_if { ::File.exists?("/home/#{backup_user}/.ssh/authorized_keys")}
end

file "/home/#{monitor_user}/.ssh/authorized_keys" do
  owner monitor_user
  mode  0600
  content "#{monitor_ssh_pubkey} #{monitor_user}"
  not_if { ::File.exists?("/home/#{monitor_user}/.ssh/authorized_keys")}
end

execute "disable_pass_expiry" do
  command "chage -I -1 -m 0 -M 99999 -E -1 cadmin"
end
