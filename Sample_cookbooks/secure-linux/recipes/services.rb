slist = %w(#{node['services']['enable']})
 case node['platform_family']
  when 'debian', 'ubuntu'
   # do debian, ubuntu things
  when 'rhel', 'centos', 'fedora'
    slist.each do |srv|
      execute "#{srv}" do
        command "chkconfig –level 345 #{srv} on"
      end
    end
end