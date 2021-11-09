
# set the xdg home env varibale for the user
[Environment]::SetEnvironmentVariable("XDG_CONFIG_HOME", "$env:USERPROFILE\.config", [System.EnvironmentVariableTarget]::User)


# link from the powershell profile in my .config directory to the default location for it 
New-Item -ItemType SymbolicLink -Path C:\Users\ac00\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1 -Target .\Microsoft.PowerShell_profile.ps1
