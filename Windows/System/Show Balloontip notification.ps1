<#

	.SYNOPSIS
	Shows a BalloonTip popup to the user
	
	.NOTES
	Showballoontip( [int] TIMEOUT [milliseconds], [string] TITLE, [string] MESSAGE, [System.Windows.Forms.Tooltipicon] ICON )
	
	System.Windows.Forms.Tooltipicon Enum Values: None, Info, Warning, Error
	
	TAGS: "Notification", "Popup", "Notify", "Alert"
	
#>

[Reflection.Assembly]::Loadwithpartialname('System.Windows.Forms') 	| Out-Null;
[Reflection.Assembly]::Loadwithpartialname('System.Drawing') 		| Out-Null;

function ShowNotifyIcon
{
	param(
	[Parameter(Mandatory=$false)]
	[String]$Title = "Header Msg", 
	[Parameter(Mandatory=$false)]
	[String]$Msg = "Message",
	[Parameter(Mandatory=$false)]
	[System.Windows.Forms.Tooltipicon]$Icon = [System.Windows.Forms.Tooltipicon]::Info
	)
	$Notify 		= New-Object System.Windows.Forms.Notifyicon;
	$Notify.Icon 	= [System.Drawing.SystemIcons]::Information;
	$Notify.Visible = $true;
	
	$Notify.Showballoontip(90000,$Title,$Msg,$Icon);
}

#ShowNotifyIcon -Title "Header Message" -Msg "Message";
