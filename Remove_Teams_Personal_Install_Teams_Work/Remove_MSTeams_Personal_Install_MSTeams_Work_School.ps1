## Check if Microsoft Teams (Personal) is available and Remove the app when possible.

if ($null -eq (Get-AppxPackage -Allusers -Name MicrosoftTeams)) {
    Write-Host "Microsoft Teams (Personal) not available"
}
Else {
    Get-AppxPackage -AllUsers -Name MicrosoftTeams | Remove-AppxPackage -AllUsers -ErrorAction Stop
    Write-Host "Removed Microsoft Teams (Personal)"  
}


## Install Microsoft Teams Machine Wide 64-bit version

if (Test-Path "C:\Program Files (x86)\Teams Installer") {
    Write-Host "Micorosoft Teams Machine Wide 64-bit is already installed"
    Exit 0
}
Else { 
    start-process "Teams_windows_x64.msi" -Wait -ArgumentList "ALLUSERS=1"
    Write-Host "Installed Microsoft Teams Machine Wide 64-bit"
    Exit 0
}