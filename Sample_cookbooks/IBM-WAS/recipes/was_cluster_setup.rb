dmgr_start_path = node['dmgr']['start']

template "/tmp/filename.py" do
  source "filename.py.erb"
  mode '0755'
  owner 'root'
  group 'root'
end

execute "create_cluster" do
  command ".#{dmgr_start_path}/wsadmin.sh -lang jython -f /tmp/filename.py"
end
