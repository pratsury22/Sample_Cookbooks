case node["platform"]
  when "debian", "ubuntu"
  # do debian/ubuntu things
  when "redhat", "centos", "fedora"
  if node['platform_version'].to_f >= 7 
    template '/usr/lib/sysctl.d/00-system.conf' do
      source 'sysctl-el7.conf.erb'
      mode 0640
      owner 'root'
      group 'root'
    end  
  else
    template '/etc/sysctl.conf' do
      source 'sysctl.conf.erb'
      mode 0640
      owner 'root'
      group 'root'
    end  
end
end
execute 'reload sysctl' do
  command "sysctl -p"
end  
