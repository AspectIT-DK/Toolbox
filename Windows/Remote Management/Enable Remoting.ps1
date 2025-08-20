#Enable PS Remote Management
Enable-PSRemoting

# Add all IPs and Hostnames as trusted hosts (Insecure)
Set-Item WSMan:\localhost\Client\TrustedHosts -Value *

# Add specific IP as trusted host
Set-Item WSMan:\localhost\Client\TrustedHosts -Value 192.168.16.69
