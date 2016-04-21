powershell_script 'Add_computer_to_domain' do
  action :run
  code <<-EOH
    $domain = "ctstest1.com"
    $password = "Password1" | ConvertTo-SecureString -asPlainText -Force
    $username = "$domain\myUserAccount" 
    $credential = New-Object System.Management.Automation.PSCredential($username,$password)
    Add-Computer -DomainName $domain -Credential $credential
  EOH
end
