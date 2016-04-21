template '/etc/ssh/ssh-banner' do
  source 'ssh-banner.erb'
  mode '0600'
  owner 'root'
  group 'root'
end

case node["platform"]
  when "debian", "ubuntu"
  #do debian/ubuntu things
  when "redhat", "centos", "fedora"
    if node['platform_version'].to_f >= 7
      template '/etc/ssh/sshd_config' do
        source 'sshd7.conf.erb'
        mode '0600'
        owner 'root'
        group 'root'
        variables(
          users: node['ssh']['allowed-users']
        )
        notifies :restart, 'service[sshd]', :immediately
      end
    else
      template '/etc/ssh/sshd_config' do
        source 'sshd.conf.erb'
        mode '0600'
        owner 'root'
        group 'root'
        variables(
          users: node['ssh']['allowed-users']
        )
        notifies :restart, 'service[sshd]', :immediately
     end
  end
end
service 'sshd' do
  supports [:start, :restart, :reload, :status]
  action [:enable, :start]
end
