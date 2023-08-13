# Install Active Directory Domain Services feature
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Configure the forest and domain
$DomainAdminPassword = ConvertTo-SecureString "AdminPassword123" -AsPlainText -Force
$SafeModePassword = ConvertTo-SecureString "SafeModePass123" -AsPlainText -Force

# Create a new AD Forest and Domain
Install-ADDSForest -DomainName "yourdomain.local" `
                   -DomainNetbiosName "YOURDOMAIN" `
                   -ForestMode "Windows2016Forest" `
                   -DomainMode "Windows2016Domain" `
                   -InstallDns `
                   -CreateDnsDelegation:$false `
                   -SafeModeAdministratorPassword $SafeModePassword `
                   -Force:$true

# Configure DNS settings
$DnsServerIpAddress = "192.168.1.10"
$PrimaryDnsZone = "yourdomain.local"
$ReverseDnsZone = "1.168.192.in-addr.arpa"

Set-DnsServerPrimaryZone -ZoneName $PrimaryDnsZone -ReplicationScope "Forest"
Add-DnsServerPrimaryZone -Name $ReverseDnsZone -ReplicationScope "Forest"

# Configure DHCP integration
$DhcpServerIpAddress = "192.168.1.20"
$DhcpScopeStartRange = "192.168.1.50"
$DhcpScopeEndRange = "192.168.1.100"
$DhcpScopeSubnetMask = "255.255.255.0"

Install-WindowsFeature -Name DHCP

Add-DhcpServerInDC -DnsName "yourdomain.local"

Add-DhcpServerv4Scope -Name "VLAN1Scope" `
                      -StartRange $DhcpScopeStartRange `
                      -EndRange $DhcpScopeEndRange `
                      -SubnetMask $DhcpScopeSubnetMask

Set-DhcpServerv4OptionValue -DnsDomain "yourdomain.local" `
                           -DnsServer $DnsServerIpAddress `
                           -Router "192.168.1.1"

# Create an Organizational Unit (OU)
$OUPath = "OU=Computers,DC=yourdomain,DC=local"
New-ADOrganizationalUnit -Name "Computers" -Path $OUPath

# Create a Security Group
$GroupPath = "OU=Groups,DC=yourdomain,DC=local"
New-ADGroup -Name "ITAdmins" -Path $GroupPath -GroupCategory Security -GroupScope Global

# Create a User Account
$UserPath = "OU=Users,DC=yourdomain,DC=local"
New-ADUser -Name "JohnDoe" -Path $UserPath -AccountPassword (ConvertTo-SecureString "Password123" -AsPlainText -Force) -Enabled $true

# Add User to Group
Add-ADGroupMember -Identity "ITAdmins" -Members "JohnDoe"
