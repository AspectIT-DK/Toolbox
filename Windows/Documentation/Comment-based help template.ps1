<#
	.SYNOPSIS
	

	.DESCRIPTION
	

	.PARAMETER p1
	

	.INPUTS
	

	.OUTPUTS
	
#>

<#
	.SYNOPSIS
	Performs monthly data updates.

	.DESCRIPTION
	The Update-Month.ps1 script updates the registry with new data generated
	during the past month and generates a report.

	.PARAMETER InputPath
	Specifies the path to the CSV-based input file.

	.PARAMETER OutputPath
	Specifies the name and path for the CSV-based output file. By default,
	MonthlyUpdates.ps1 generates a name from the date and time it runs, and
	saves the output in the local directory.

	.INPUTS
	None. You can't pipe objects to Update-Month.ps1.

	.OUTPUTS
	None. Update-Month.ps1 doesn't generate any output.

	.EXAMPLE
	PS> .\Update-Month.ps1

	.EXAMPLE
	PS> .\Update-Month.ps1 -InputPath C:\Data\January.csv

	.EXAMPLE
	PS> .\Update-Month.ps1 -InputPath C:\Data\January.csv -OutputPath C:\Reports\2009\January.csv
#>
