Chef::Log.info("Installing nxlog")

powershell_script 'Install_nxlog' do
  action:run
  code <<-EOH
    msiexec /package 'C:\\Users\\chefadmin\\Desktop\\nxlog-ce-2.8.1248.msi' /quiet /qn /norestart
  EOH
end

template 'C:\\Program Files (x86)\\nxlog\\conf\\nxlog.conf' do
  source 'nxlog.conf.erb'
  mode '0755'
end

powershell_script 'Start_nxlog' do
  action:run
  code <<-EOH
    net start nxlog
  EOH
end
