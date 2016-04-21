case node["platform"]
  when "redhat", "centos", "fedora"
    template '/etc/security/limits.conf' do
      source 'limits.conf.erb'
      mode 0640
      owner 'root'
      group 'root'
      variables({
       :nofilemin => node[:oracle11g][:nofilemin],
       :nofilemax => node[:oracle11g][:nofilemax],
       :nprocmin => node[:oracle11g][:nprocmin],
       :nprocmax => node[:oracle11g][:nprocmax],
       :stackmin => node[:oracle11g][:stackmin],
       :stackmax => node[:oracle11g][:stackmax]
      })
    end
end

case node["platform"]
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
