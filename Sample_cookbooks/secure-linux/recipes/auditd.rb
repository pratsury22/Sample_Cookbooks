service 'auditd' do
  supports [:start, :restart, :reload, :status]
  action [:enable, :start]
end