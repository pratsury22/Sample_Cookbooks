# Installs and configures Oracle
#
oracle1 = node['oracle11g']['package1']
oracle2 = node['oracle11g']['package2']
oracle3 = node['oracle11g']['package3']
oracle_extract = node['oracle11g']['extract-dir']


package "unzip"
package "ksh"

bash 'read_sys_config' do
  code <<-EOH
    chmod 644 /etc/security/limits.conf
    chmod 644 /etc/sysctl.conf
  EOH
end

directory "#{oracle_extract}" do
  owner 'oracle'
  group 'oinstall'
  mode '0755'
end

bash "unzip-oracle11g" do
  user 'root'
  code <<-EOH
    unzip #{oracle1} -d #{oracle_extract}
    unzip #{oracle2} -d #{oracle_extract}
    unzip #{oracle3} -d #{oracle_extract}
  EOH
  not_if { ::File.exists?("#{oracle_extract}/database/runInstaller")}
end

template "#{oracle_extract}/database/db_install.rsp"  do
  source "db_install.rsp.erb"
  mode '0640'
  owner 'oracle'
  group 'oinstall'
end

template "/oracle/database/install/database/stage/cvu/cv/admin/cvu_config" do
  source "cvu_config.erb"
  mode '0640'
  owner 'oracle'
  group 'oinstall'
end

bash 'install_oracle' do
  user 'root'
  cwd "#{oracle_extract}"
  code <<-EOH
    runuser -l oracle -c "#{oracle_extract}/database/runInstaller -silent -force -responseFile #{oracle_extract}/database/db_install.rsp"
  EOH
end
