Get-VM

<# Once you have the VM name, run the command below, replacing ‘Windows 11’ with the name of the VM you want to stop: #>

$VmGUID = (Get-VM 'Windows 11').id

$VMWMProc = (Get-WMIObject Win32_Process | ? {$_.Name -match 'VMWP' -and $_.CommandLine -match $VmGUID})

Stop-Process ($VMWMProc.ProcessId) –Force

