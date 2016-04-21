case node["platform"]
  when "debian", "ubuntu"
  # do debian/ubuntu things
  when "redhat", "centos", "fedora"
    if node["platform_version"] < "7" 
      ruby_block "ensure default run level 3" do
        block do
      	  rc = Chef::Util::FileEdit.new("/etc/inittab")
          rc.search_file_replace_line(/id:$/, "id:3:initdefault:")
          rc.write_file
        end
      end  
      ruby_block "disable Alt Ctl Del Reboot" do
        block do
          rc = Chef::Util::FileEdit.new("/etc/inittab")
          rc.search_file_replace_line(/ca::ctrlaltdel:\/sbin\/shutdown$/,  "#ca::ctrlaltdel:\/sbin\/shutdown -t3 -r now")
          rc.write_file
        end
      end  
  else
    execute "set to multiuser target on rhel7" do
      command "systemctl set-default multi-user.target"
      not_if ("systemctl get-default | grep -v grep | grep multi-user.target ")
    end	
    execute "set to multiuser target on rhel7" do
      command "ln -s /dev/null /etc/systemd/system/ctrl-alt-del.target"
      not_if do ::File.exists?('/etc/systemd/system/ctrl-alt-del.target') end
    end
  end
end
