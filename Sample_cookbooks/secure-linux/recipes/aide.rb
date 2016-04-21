package "aide"

execute "Initialize AIDE" do
 command "/usr/sbin/aide --init"	
  not_if do ::File.exists?(node['aide']['scanfile']) end 
end

