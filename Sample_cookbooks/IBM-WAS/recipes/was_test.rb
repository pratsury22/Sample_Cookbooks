host1 = node['wasclusternode1']['hostname']
ipaddress1 = node['wasclusternode1']['ipaddress']

host2 = node['wasclusternode2']['hostname']
ipaddress2 = node['wasclusternode2']['ipaddress']

bash "test_environment1" do
  user 'root'
  code <<-EOH
  echo #{node1}
  echo #{ipaddress1}
  EOH
end

bash "test_environment2" do
  user 'root'
  code <<-EOH
  echo #{node2}
  echo #{ipaddress2}
  EOH
end
