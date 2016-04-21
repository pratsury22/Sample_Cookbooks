pubkey = node['ssh']['pubkey']
user "cmonitor" do
  supports :manage_home => true
  comment 'Cognizant Monitoring User'
  password '$1$b7VbWIkD$y6GFiGQsMCPc6uZ7u/Qy3.'
  shell '/bin/bash'
  action :create
end

user "cmanage" do
  supports :manage_home => true
  comment 'Cognizant Management User'
  password '$1$eSDzza.8$tumHEOczzRghqkuasg8vg1'
  shell '/bin/bash'
  action :create
end

user "cadmin" do 
  supports :manage_home => true
  comment 'Cognizant admin User'
  password '$1$Q.yxY6Hj$CE9UjwyRaCb3TCf9.HPsC.'
  shell '/bin/bash'
  action :create
end

user "cbackup" do
  supports :manage_home => true
  comment 'Cognizant backup User'
  password '$1$F6HUpqOZ$leQuMZo9YOIrf8fd7OuLh.'
  shell '/bin/bash'
  action :create
end

%w(cmonitor cmanage cadmin cbackup).each do |username|
  directory "/home/#{username}/.ssh" do
    owner username
    group username
  end
end

%w(cmonitor cmanage cadmin cbackup).each do |username|
  cookbook_file "#{pubkey}" do
    path "/home/#{username}/.ssh/authorized_keys"
    action :create_if_missing
    owner username
    group username
    mode '0600'
  end
end

execute "disable_pass_expiry" do
  command "chage -I -1 -m 0 -M 99999 -E -1 cadmin"
end

case node["platform"]
  when "debian", "ubuntu"
    %w(#node['security']['users']['nologin']).each do |user|
	execute "#{user}" do
	usermod -s /usr/sbin/nologin #{user}
	end
  end
  when "redhat", "centos", "fedora"
    %w(#node['security']['users']['nologin']).each do |user|
	execute "#{user}" do
	usermod -s /sbin/nologin #{user}
	end
	end
end