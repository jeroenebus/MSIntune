<#
.Synopsis
    Microsoft Teams Personal removal script and Microsoft Teams Machine Wide Installer script.
.DESCRIPTION
    This script allows you to remove the Microsoft Teams Personal App (Appx) and install the Microsoft Teams Machine Wide Installer. 
    The Microsoft Teams Machine Wide Installer will install Microsoft Teams for Work or School in the localappdata of each user that logs in.
.EXAMPLE
    
    ## Uninstall Microsoft Teams (Personal) and Install Microsoft Teams Machine Wide 64-bit version
    Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1 -install

    ## Uninstall Teams Machine Wide-Installer Only
    Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1 -uninstall
    
    ## Install Microsoft Teams Machine-Wide 64-bit version only (no uninstall of Microsoft Teams (Personal))
    Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1 -installTeamsMachineWideOnly
    
    ## Uninstall Microsoft Teams (Personal) only
    Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1 -RemovePersonalOnly

.NOTES
    Filename: Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1
    Author: Jeroen Ebus (https://manage-the.cloud) 
    Modified date: 2023-10-18
    Version 1.0 - Release notes/details
#>

## Define parameters for the script
param (
    [switch]$install,
    [switch]$uninstall,
    [switch]$installTeamsMachineWideOnly,
    [switch]$RemovePersonalOnly
)

## Define variables for the script
$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

## Uninstall Teams Machine Wide-Installer Only
if ($uninstall) {
    ## Define variables for uninstall
    $productName = "Teams Machine-Wide Installer"
    $uninstallDetection = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object { $_.DisplayName -match "$productName" } | Select-Object -Property UninstallString
    $productCode = $uninstallDetection.UninstallString
    $msiguid = $productCode.TrimStart("MsiExec.exe /I")

    ## Uninstall Microsoft Teams Machine Wide Installer 64-bit version
    Start-Process "msiexec.exe" -Wait -ArgumentList "/x $msiguid /quiet"
    Write-Host "Uninstalled Microsoft Teams Machine Wide 64-bit!"
    Exit 0
}

## Uninstall Microsoft Teams (Personal) and Install Microsoft Teams Machine Wide 64-bit version
elseif ($install) {
    ## Check if Microsoft Teams (Personal) is installed and remove the app if possible.
    if ($null -eq (Get-AppxPackage -Allusers -Name "MicrosoftTeams")) {
        Write-Host "Microsoft Teams (Personal) not installed!"
    }
    else {
        Get-AppxPackage -AllUsers -Name "MicrosoftTeams" | Remove-AppxPackage -AllUsers -ErrorAction Stop
        Write-Host "Removed Microsoft Teams (Personal)!"  
    }

    ## Install Microsoft Teams Machine Wide 64-bit version
    if (Test-Path "${env:ProgramFiles(x86)}\Teams Installer") {
        Write-Host "Microsoft Teams Machine Wide 64-bit is already installed!"
        Exit 0
    }
    else { 
        Start-Process "$scriptDir\Teams_windows_x64.msi" -Wait -ArgumentList "/quiet /norestart ALLUSERS=1"
        Write-Host "Installed Microsoft Teams Machine Wide 64-bit!"
        Exit 0
    }
}

## Install Microsoft Teams Machine-Wide 64-bit version only (no uninstall of Microsoft Teams (Personal))
elseif ($installTeamsMachineWideOnly) {
    ## Install Microsoft Teams Machine Wide 64-bit version
    if (Test-Path "${env:ProgramFiles(x86)}\Teams Installer") {
        Write-Host "Microsoft Teams Machine Wide 64-bit is already installed!"
        Exit 0
    }
    else { 
        Start-Process "$scriptDir\Teams_windows_x64.msi" -Wait -ArgumentList "/quiet /norestart ALLUSERS=1"
        Write-Host "Installed Microsoft Teams Machine Wide 64-bit!"
        Exit 0
    }
}

## Uninstall Microsoft Teams (Personal) only
elseif ($RemovePersonalOnly) {
    ## Check if Microsoft Teams (Personal) is installed and remove the app if possible.
    if ($null -eq (Get-AppxPackage -Allusers -Name "MicrosoftTeams")) {
        Write-Host "Microsoft Teams (Personal) not installed!"
    }
    else {
        Get-AppxPackage -AllUsers -Name "MicrosoftTeams" | Remove-AppxPackage -AllUsers -ErrorAction Stop
        Write-Host "Removed Microsoft Teams (Personal)!"  
    }
    Exit 0
}
