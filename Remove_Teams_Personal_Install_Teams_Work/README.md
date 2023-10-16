1. Download the latest version of the Microsoft-Win32-Content-Prep-Tool via:

     https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool/blob/master/IntuneWinAppUtil.exe

2. Download the lastest version of the Classic Microsoft Teams (work or school) 64-bit via: 

    https://teams.microsoft.com/downloads/desktopurl?env=production&plat=windows&arch=x64&managedInstaller=true&download=true

3. Download the removal and installation script via: 

    https://github.com/jeroenebus/MSIntune/blob/main/Remove_Teams_Personal_Install_Teams_Work/Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1

4. Put the Teams_windows_x64.msi and Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1 in a folder that's called "Source" for example.

5. Open a CMD, navigate to the folder where the IntuneWinAppUtil.exe is located and start the IntuneWinAppUtil.exe.

6. Please specify the source folder: ".\Source"

7. Please specify the setup file: "Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1"

8. Please specify the output folder: "\Package"

9. Do you want to specify catalog folder (Y/N)? "N"

10. Rename "Remove_MSTeams_Personal_Install_MSTeams_Work_School.intunewin" to "Install.intunewin" for example.

11. Upload the app into Microsoft Intune as a Windows app (Win32).

12. Use as "Install Command": powershell.exe -executionpolicy remotesigned -file ".\Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1".

13. Use as "Uninstall Command": powershell.exe -executionpolicy remotesigned -file ".\Remove_MSTeams_Personal_Install_MSTeams_Work_School.ps1"
    
     (There no real uninstall in the package so this is more like a dummy uninstall)
