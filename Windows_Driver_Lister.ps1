clear-host
#Import Library for forms
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Drawing
Add-Type -AssemblyName System.Windows.Forms
#Setting current running user desktop
$export=[environment]::GetFolderPath([System.Environment+SpecialFolder]::Desktop)
#Returns a WindowsIdentity object that represents the current Windows user.
$CurrentWindowsIdentity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
#creating a new object of type WindowsPrincipal, and passing the Windows Identity to the constructor.
$CurrentWindowsPrincipal = New-Object System.Security.Principal.WindowsPrincipal($CurrentWindowsIdentity)
#Return True if specific user is Admin else return False
if ($CurrentWindowsPrincipal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) 
{
    #Dialog boxes to help show information without reading the console
    [System.Windows.MessageBox]::Show('This script is going to grab driver information, click Ok to begin','Driver Information','Ok','Information')
        Get-WindowsDriver -Online -All | Out-File -FilePath "$export\BeforeDriverInstall.txt"
    [System.Windows.MessageBox]::Show('Now Install the drivers and click OK when done, if you need to restart the computer do not click restart','Driver Information','Ok','Information')
        Get-WindowsDriver -Online -All | Out-File -FilePath "$export\AfterDriverInstall.txt"
    [System.Windows.MessageBox]::Show('The files will be on the desktop named BeforeDriverInstall.txt and AfterDriverInstall.txt if you ran this with elevated admin without using an admin profile it will be on the chosen administrators desktop.' ,'Driver Information','Ok','Information')
exit
}
else { 
    Write-Warning "Insufficient permissions to run this script. Open the PowerShell console as an administrator and run this script again."
    Write-Output "Auto-closing in 10 seconds"
    Timeout 10 
Exit 
}
#Created By Chris Masters