<#
	.DESCRIPTION
	Adding a new [Explorer.exe] context menu item to create an empty custom filetype.
	
	.NOTES
	TAGS: "Windows Registry", "New Item", "Context nenu", "Right-click menu", "New file"
#>

# Accessing the registry directly from Powershell uses the PSProvider type 'Registry'.

<#
# Get-PSDrive shows the current active PSDrives and their associated PSProvider.

Name           Used (GB)     Free (GB) Provider      Root
----           ---------     --------- --------      ----
Alias                                  Alias             
C                 120.73         38.59 FileSystem    C:\ 
Cert                                   Certificate   \   
D                 329.92        441.17 FileSystem    D:\
E                 338.57       1524.43 FileSystem    E:\
Env                                    Environment      
F                   4.14       1858.86 FileSystem    F:\
Function                               Function         
HKCU                                   Registry      HKEY_CURRENT_USER
HKLM                                   Registry      HKEY_LOCAL_MACHINE    

#>

# Add the HKEY_CLASSES_ROOT Registry Hive as an addressable drive
New-PSDrive -Name "HKCR" -PSProvider Registry -Root "HKEY_CLASSES_ROOT";

# In this example we'll create a new context menu item to add markdown files, extension .md
# First check that the key doesn't already exist
Get-ItemProperty -Path HKCR:\.md;

# If it exists, check to see if it has any items associated
Get-Childitem -Path HKCR:\.md;

# Satisfied that we won't be overwriting anything, we can add the new menu item

# Create the key if it doesn't exist
New-Item -Path HKCR:\ -Name ".md";

# Add the subkey 'ShellNew'
New-Item -Path HKCR:\.md\ -Name "ShellNew";

# Add associator 'Markdown.Document' to allow friendly-name to be set

$Associator = @{
    Path = 'HKCR:\.md'
    Name = '(default)'
    PropertyType = 'String'
    Value = 'Markdown.Document'
}
New-ItemProperty @Associator;

# Add entry to tell Windows we want to create new blank files with the .md extension

$EmptyFileValue = @{
    Path = 'HKCR:\.md\ShellNew\'
    Name = 'NullFile'
    PropertyType = 'String'
    Value = ''
}
New-ItemProperty @EmptyFileValue;

# Add friendly name to the list so it shows up as "Markdown File" when you right-click -> create new

New-Item -Path HKCR:\ -Name "Markdown.Document";
Set-ItemProperty -Path "HKCR:\Markdown.Document" -Name '(default)' -Value 'Markdown File';