case node["platform"]
  when "debian", "ubuntu"
  #do debian/ubuntu things
  when "redhat", "centos", "fedora"
    if node['platform_version'].to_f >= 7
  #do debian/ubuntu things
    end
    else
      template '/etc/sysconfig/init' do
        source 'init.erb'
        mode '0644'
        owner 'root'
        group 'root'
        notifies :restart, 'service[sshd]', :immediately
      end
    end
