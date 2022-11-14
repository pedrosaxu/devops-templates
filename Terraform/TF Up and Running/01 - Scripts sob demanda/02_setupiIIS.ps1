Install-WindowsFeature -name Web-Server -IncludeManagementTools
remove-item C:\inetpub\wwwroot\iisstart.htm
New-Item -Path C:\inetpub\wwwroot\iisstart.htm -ItemType file -Value "Hello World"
Start-Service -Name W3SVC
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False # Desativar firewall do Windows
