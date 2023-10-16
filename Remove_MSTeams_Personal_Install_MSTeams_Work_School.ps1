## Check if Teams Home App is available and Remove The app when possible.

if ($null -eq (Get-AppxPackage -Allusers -Name MicrosoftTeams)) {
    Write-Host "Microsoft Teams Client not available"
}
Else {
    Get-AppxPackage -AllUsers -Name MicrosoftTeams | Remove-AppxPackage -AllUsers -ErrorAction Stop
    Write-Host "Removed Microsoft Teams"  
}


## Install Microsoft Teams Machine Wide

if (Test-Path "C:\Program Files (x86)\Teams Installer") {
    Write-Host "Teams Machine Wide installer is already installed"
    Exit 0
}
Else { 
    start-process "Teams_windows_x64.msi" -Wait -ArgumentList "ALLUSERS=1"
    Write-Host "Installed Microsoft Teams"
    Exit 0
}
