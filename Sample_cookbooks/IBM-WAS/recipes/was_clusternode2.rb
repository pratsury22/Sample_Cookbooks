custom_profile_path = node['custom']['profile']
federate_node2_dmgr = node['federate']['node2']

execute "create_custom_profile" do
  command ".#{custom_profile_path}/manageprofiles.sh -create -profileName Custom02 -profilePath /opt/IBM/profiles/Custom02 -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/managed -nodeName TestNode02"
end

clusternode2 = ""
search(:node, 'role:ibm-was-cluster').each do |node|
clusternode2 = node[:fqdn]
end
puts "#{clusternode2}"

execute "federate_node2_dmgr" do
  command ".#{federate_node2_dmgr}/addNode.sh #{clusternode2} 8879"
end
