execute "password_algo" do
  command "authconfig --passalgo=sha512 --update"
end
