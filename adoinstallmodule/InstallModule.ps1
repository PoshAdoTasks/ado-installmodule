[CmdletBinding()]
param()

[string]$Name = Get-VstsInput -Name Name
[string]$Scope = Get-VstsInput -Name Scope
[string]$Version = Get-VstsInput -Name Version
[boolean]$AllowClobber = Get-VstsInput -Name AllowClobber -AsBool

Write-Verbose "Name          : $Name";
Write-Verbose "Scope         : $Scope";
Write-Verbose "Version       : $Version";
Write-Verbose "AllowClobber  : $AllowClobber";

Trace-VstsEnteringInvocation $MyInvocation;

try {
    $ErrorActionPreference = 'Stop';
    $Error.Clear();

    # Check if the module is already installed and get the installed version
    $installedModule = Get-InstalledModule -Name $Name -ErrorAction SilentlyContinue
    if ($installedModule -and $installedModule.Version -eq $Version) {
        Write-Host "Module '$Name' version $Version is already installed. Skipping installation."
        return
    }
    else {
        if ($installedModule) {
            Write-Verbose "Module '$Name' is installed but the version is $($installedModule.Version). Required version is $Version."
        }
        else {
            Write-Verbose "Module '$Name' is not installed."
        }
    }

    # Check if the specified version is available
    if ($Version) {
        $availableVersion = Find-Module -Name $Name -RequiredVersion $Version -ErrorAction SilentlyContinue
        if (-not $availableVersion) {
            throw "Specified version $Version of module $Name is not available."
        }
    }

    # Install or update the module
    if ($AllowClobber) {
        if ($Version) {
            Install-Module -Name $Name -RequiredVersion $Version -Scope $Scope -AllowClobber -Force;
        }
        else {
            Install-Module -Name $Name -Scope $Scope -AllowClobber -Force;
        }
    }
    else {
        if ($Version) {
            Install-Module -Name $Name -RequiredVersion $Version -Scope $Scope;
        }
        else {
            Install-Module -Name $Name -Scope $Scope;
        }
    }

    # Verify the installation
    $installedModule = Get-InstalledModule -Name $Name
    Write-Host "Installed Module: $($installedModule.Name) Version: $($installedModule.Version)"
}
catch {
    throw $_;
}
finally {
    Trace-VstsLeavingInvocation $MyInvocation;
}