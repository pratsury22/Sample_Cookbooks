ibm_was_extract = node['ibm-was']['extract-dir']
ibm_im_path = node['ibm-im']['path']


execute "install-ibm-was-plugin" do
  command "#{ibm_im_path}/imcl install com.ibm.websphere.PLG.v85 -repositories #{ibm_was_extract} -installationDirectory /opt/IBM/HTTPServer -acceptLicense -showProgress  -log /tmp/plg_install.xml"
end

execute "install-im-was-toolbox" do
  command "#{ibm_im_path}/imcl install com.ibm.websphere.WCT.v85 -repositories #{ibm_was_extract} -acceptLicense -installationDirectory /opt/IBM/WebSphere/Toolbox -showProgress -log /tmp/wct_install.xml"
end

