ibm_ihs_fp_package1 = node['ibm_ihs_fp']['package1']
ibm_ihs_fp_package2 = node['ibm_ihs_fp']['package2']
ibm_im_path = node['ibm-im']['path']
ibm_ihs_fp_extract = node['ibm_ihs_fp']['extract']
ibm_ihs_start = node['ibm-ihs']['start']

package "unzip"

execute "stop-ibm-ihs" do
  command "#{ibm_ihs_start}/apachectl -k stop"
end

directory "#{ibm_ihs_fp_extract}" do
  action :create
  mode '755'
  user 'root'
  group 'root'
end

bash "unzip-ibm-ihs" do
  user 'root'
  code <<-EOH
    unzip #{ibm_ihs_fp_package1} -d #{ibm_ihs_fp_extract}
    unzip #{ibm_ihs_fp_package2} -d #{ibm_ihs_fp_extract}
    EOH
  not_if { ::File.exists?("#{ibm_ihs_fp_extract}/repository.config")}
end

bash "install_ihs_fixpack" do
  user "root"
  code <<-EOH
    currentversion=$(/opt/IBM/HTTPServer/bin/versionInfo.sh | grep 'Version               8.5.5.0'| awk '{print $2}')
    if [ "$currentversion" == "8.5.5.0" ];
      then
        #{ibm_im_path}/imcl install com.ibm.websphere.IHS.v85 -repositories #{ibm_ihs_fp_extract} -installationDirectory /opt/IBM/HTTPServer -showProgress -acceptLicense
      else
        echo "IBM HTTPServer is allready at updated level"
      fi
    EOH
end

execute "start-ibm-ihs" do
  command "#{ibm_ihs_start}/apachectl -k start"
end

