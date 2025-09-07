<#

	.SYNOPSIS
	Checks if a specific device ID has changed and if it has, then notify the user.
	$PnPArgs determines the specific Device. Use Get-PnPDevice to get more info. 
	For best results, create a scheduled task.
	
#>

function ShowNotifyIcon
{
	[Reflection.assembly]::loadwithpartialname('System.Windows.Forms') | Out-Null;
	[Reflection.assembly]::loadwithpartialname('System.Drawing') | Out-Null;
	$Notify = New-Object System.Windows.Forms.Notifyicon;
	$Notify.Icon = [System.Drawing.SystemIcons]::Information;
	$Notify.Visible = $true;
	$Notify.Showballoontip(900000,'Audio Device ID Changed','Audio Device ID has Changed',[System.Windows.Forms.Tooltipicon]::Info);
}

#$DebugPreference = "Continue";
$MAXLOGENTRIES = 10;
$Path = ((Get-Childitem Env:\LOCALAPPDATA).Value) + "\DeviceIDCheckerTask";
$LogFilePath = $Path + "\devid.log";
$PnPArgs = @{
	Class = "Media"
	Status = "OK"
	FriendlyName = "Arctis Nova Pro"
}


$PathExists = Test-Path $Path;
if(!$PathExists)
{
	try
	{
		New-Item -Path $Path -ItemType Directory;
	}
	catch
	{
		# Can't create the folder for some reason. Let the world know, then commit die.
		Write-Error $_;
		exit 1;
	}
}

$LogFileExists = Test-Path $LogFilePath;
if(!$LogFileExists)
{
	try
	{
		New-Item -Path $LogFilePath -ItemType File;
	}
	catch
	{
		# Can't create the log file for some reason. Let the world know, then commit die.
		Write-Error $_;
		exit 1;
	}
}

function Write-ToLogFile([string]$Msg)
{
	Add-Content -Path $LogFilePath -Value $Msg -NoNewLine;
	Add-Content -Path $LogFilePath -Value (";" + (Get-Date -Format "ddMMyyyy"));
}


$Result = Get-PnpDevice @PnPArgs;

if($Result.GetType().Name -ne "CimInstance")
{
	Write-Error "Expecting single device CimInstance, but type is not CimInstance. Did search query return multiple devices?" -Category InvalidType;
	exit 1;
}

$CurrentDeviceID = $Result.InstanceId;

if([string]::IsNullOrEmpty("$CurrentDeviceID"))
{
	Write-Error "Device Instance ID is empty or null" -Category InvalidResult;
	exit 1;
}

### Boilerplate done, check log for Device ID changes
### Logfile Format: INSTANCEID ; DATE   semicolon is delimiter
### Example: USB\VID_1038&PID_12CB&MI_00\6&7F5EA96&0&0000;07092025

[System.Array]$LogContent = Get-Content $LogFilePath;

if($LogContent.Count -eq 0)
{
	Write-ToLogFile($CurrentDeviceID);
}
else
{
	$MostRecentInstanceID = $LogContent[$($LogContent.Count)-1].Split(";")[0];
	
	if(!$MostRecentInstanceID -eq $CurrentDeviceID)
	{
		ShowNotifyIcon;
	}
	
	Write-ToLogFile($CurrentDeviceID);
}

if($LogContent.Count -gt $MAXLOGENTRIES)
{
	Clear-Content -Path $LogFilePath;
	Write-ToLogFile($CurrentDeviceID);
}