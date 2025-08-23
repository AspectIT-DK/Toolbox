# Allow RDP through Firewall
# RAW PORTS: 
# RDWeb via HTTPS 	- TCP 443
# RDP Protocol 		- TCP 3389, UDP 3389
$FWRules = @(
	"RemoteDesktop-Shadow-In-TCP",
	"RemoteDesktop-UserMode-In-TCP",
	"RemoteDesktop-UserMode-In-UDP"
);

Foreach($Rule in $FWRules)
{
	Enable-NetFirewallRule -Name $Rule;
}

# Allow RDP Connections
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\' -Name "fDenyTSConnections" -Value 0





# https://learn.microsoft.com/en-us/troubleshoot/windows-server/remote/ports-used-by-rds  [23-AUG-2025]