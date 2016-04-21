if node['security']['patch'] == 'true'
  case node['platform_family']
  when 'debian'
    execute 'patch_debian' do
  	  command 'apt-get update && apt-get upgrade'
    end
  	
  when 'rhel'
     execute 'patch_rhel' do
  	  command 'yum -y update'
     end
  end
end