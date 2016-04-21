ibm_was_fp_package1 = node['ibm_was_fp']['package1']
ibm_was_fp_package2 = node['ibm_was_fp']['package2']
ibm_im_path = node['ibm-im']['path']
ibm_was_fp_extract = node['ibm_was_fp']['extract']
ibm_was_start = node['ibm-was']['start']

package "unzip"

execute "stop-ibm-was" do
  command "#{ibm_was_start}/stopServer.sh server1"
end

directory "#{ibm_was_fp_extract}" do
  action :create
  mode '755'
  user 'root'
  group 'root'
end

bash "unzip-ibm-was" do
  user 'root'
  code <<-EOH
    unzip #{ibm_was_fp_package1} -d #{ibm_was_fp_extract}
    unzip #{ibm_was_fp_package2} -d #{ibm_was_fp_extract}
    EOH
  not_if { ::File.exists?("#{ibm_was_fp_extract}/repository.config")}
end

bash "install_was_fixpack" do
  user "root"
  code <<-EOH
    currentversion=$(/opt/IBM/WebSphere/AppServer/bin/versionInfo.sh | grep 'Version               8.5.5.0'| awk '{print $2}')
    if [ "$currentversion" == "8.5.5.0" ];
      then
        #{ibm_im_path}/imcl install com.ibm.websphere.ND.v85 -repositories #{ibm_was_fp_extract} -installationDirectory /opt/IBM/WebSphere/AppServer -showProgress -acceptLicense
      else
        echo "IBM WAS is allready at updated level"
      fi
    EOH
end

execute "start-ibm-was" do
  command "#{ibm_was_start}/startServer.sh server1"
end

