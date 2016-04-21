template '/etc/sudoers' do
  source 'sudoers.erb'
  mode '0640'
  owner 'root'
  group 'root'
  variables(
    rootuser: node['sudo']['rootuser']
    )
end
