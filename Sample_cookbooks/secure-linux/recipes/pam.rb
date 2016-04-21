  template '/etc/pam.d/system-auth-ac' do
    source 'pam-system-auth.erb'
    mode 0640
    owner 'root'
    group 'root'
  end
