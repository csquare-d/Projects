$hostnames=hostname
Write-Host $hostname
$Password=ConvertTo-SecureString "bb123#123" -AsPlainText -Force
New-LocalUser -Name "CC1" -Password $Password
Net User "CC1" /PASSWORDREQ:YES
New-LocalUser -Name "CC2" -Password $Password
Net User "CC2" /PASSWORDREQ:YES
Add-LocalGroupMember -Group "Administrators" -Member "CC2"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "CC1"
$Domain=(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain

if ($Domain -eq $False)
{
    Write-Output "This computer is not on the Domain"
}

Disable-LocalUser -Name Guest
netsh advfirewall show currentprofile
Get-SmbShare
Get-LocalUser
Get-Service > C:\Users\Administrator\Documents\Service_List.txt
New-SMBShare -Name $hostnames -Path C:\Users\Administrator
