$hostnames=hostname
Write-Host $hostname
$Password=ConvertTo-SecureString "bb123#123" -AsPlainText -Force
New-LocalUser -Name "JTfun" -Password $Password
Net User "JTfun" /PASSWORDREQ:YES
New-LocalUser -Name "JTboo" -Password $Password
Net User "JTboo" /PASSWORDREQ:YES
Add-LocalGroupMember -Group "Administrators" -Member "JTboo"
Add-LocalGroupMember -Group "Remote Desktop Users" -Member "JTfun"
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
