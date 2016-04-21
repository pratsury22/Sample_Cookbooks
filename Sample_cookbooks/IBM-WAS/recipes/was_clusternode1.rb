dmgr_profile_path = node['dmgr']['profile']
dmgr_start_path = node['dmgr']['start']
custom_profile_path = node['custom']['profile']
federate_node1_dmgr = node['federate']['node1']

execute "create_dmgr_profile" do
  command ".#{dmgr_profile_path}/manageprofiles.sh -create -profileName Dmgr01 -profilePath /opt/IBM/profiles/Dmgr01 -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/dmgr -nodeName DmgrNode -cellName TestCell01"
end

execute "start_dmgr_manager" do
  command ".#{dmgr_start_path}/startManager.sh"
end

execute "create_custom_profile1" do
  command ".#{custom_profile_path}/manageprofiles.sh -create -profileName Custom01 -profilePath /opt/IBM/profiles/Custom01 -templatePath /opt/IBM/WebSphere/AppServer/profileTemplates/managed -nodeName TestNode01"
end

clusternode1 = ""
search(:node, 'role:dummy').each do |node|
clusternode1 = node[:fqdn]
end
puts "#{clusternode1}"

execute "federate_node1_dmgr" do
  command ".#{federate_node1_dmgr}/addNode.sh #{clusternode1} 8879"
end
