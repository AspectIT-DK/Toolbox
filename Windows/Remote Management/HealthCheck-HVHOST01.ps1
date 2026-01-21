#$Cred = Import-Clixml "F:\Keys\srv-hvhost01-adm.cred";
$Cred = Get-Credential;
$Target = "192.168.10.10" # SRV-HVHOST01


$D = Invoke-Command -ComputerName $Target -Credential $Cred -ScriptBlock {
	$os   = Get-CimInstance Win32_OperatingSystem;
	$disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'";
	
	[PSCustomObject]@{
	Hostname 		= $env:COMPUTERNAME
	Drive			= "C"
	Uptime 			= (((Get-Date) - $os.LastBootUpTime).Days)
	FreeDiskspace 	= $([math]::Round($disk.FreeSpace / 1GB, 0))
	TotalDiskspace 	= $([math]::Round($disk.Size / 1GB, 0))
	}
}

<#
         Hostname : #########
           Uptime : ### Days
 Free Diskspace # : ### GB
 Free Diskspace % : ##.#%
Total Diskspace # : ### GB

#>

$Padby = 18;
$D | 
Select-Object -Property @{Label=('Hostname').PadLeft($Padby); 				Expression={$_.Hostname}},
						@{Label=('Uptime').PadLeft($Padby); 				Expression={$_.Uptime.ToString() + " Days"}},
						@{Label=('Drive').PadLeft($Padby); 					Expression={$_.Drive}},
						@{Label=('Free Diskspace #').PadLeft($Padby); 		Expression={$_.FreeDiskSpace.ToString() + " GB"}},
						@{Label=('Free Diskspace %').Padleft($Padby);		Expression={[math]::Round($_.FreeDiskSpace / $_.TotalDiskSpace * 100, 1).ToString() + "%"}},
						@{Label=('Total Diskspace #').PadLeft($Padby); 		Expression={$_.TotalDiskSpace.ToString() + " GB"}}|
Format-List;
