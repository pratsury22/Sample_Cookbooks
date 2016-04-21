ibm_ihs_fp_package1 = node['ibm_ihs_fp']['package1']
ibm_ihs_fp_package2 = node['ibm_ihs_fp']['package2']
ibm_im_path = node['ibm-im']['path']
#ibm_was_fp_extract = node['ibm_was_fp']['extract']
ibm_ihs_fp_extract = node['ibm_ihs_fp']['extract']
package "unzip"

directory "#{ibm_ihs_fp_extract}" do
  action :create
  mode '755'
  user 'root'
  group 'root'
end

bash "unzip-ibm-was_plugin" do
  user 'root'
  code <<-EOH
    unzip #{ibm_ihs_fp_package1} -d #{ibm_ihs_fp_extract}
    unzip #{ibm_ihs_fp_package2} -d #{ibm_ihs_fp_extract}
    EOH
  not_if { ::File.exists?("#{ibm_ihs_fp_extract}/repository.config")}
end

bash "install_was_plugin_fixpack" do
  user "root"
  code <<-EOH
    currentversion=$(/opt/IBM/Plugins/bin/versionInfo.sh | grep 'Version               8.5.5.0'| awk '{print $2}')
    if [ "$currentversion" == "8.5.5.0" ];
      then
        #{ibm_im_path}/imcl install com.ibm.websphere.PLG.v85 -repositories #{ibm_ihs_fp_extract} -installationDirectory /opt/IBM/Plugins -showProgress -acceptLicense
      else
        echo "IBM WAS plugin fixpack is allready at updated level"
      fi
    EOH
end
