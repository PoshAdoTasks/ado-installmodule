[CmdletBinding()]
param()

[string]$Name = Get-VstsInput -Name Name
[string]$Scope = Get-VstsInput -Name Scope
[boolean]$AllowClobber = Get-VstsInput -Name AllowClobber -AsBool

Write-Verbose "Name          : $Name";
Write-Verbose "Scope         : $Scope";
Write-Verbose "AllowClobbber : $AllowClobber";

Trace-VstsEnteringInvocation $MyInvocation;

try {
 $ErrorActionPreference = 'Stop';
 $Error.Clear();

 if ($AllowClobber) {
  Install-Module -Name $Name -Scope $Scope -AllowClobber -Force;
 }
 else {
  Install-Module -Name $Name -Scope $Scope;
 }

 Write-Host (Get-Command -Module $Name);
}
catch {
 throw $_;
}
finally {
 Trace-VstsLeavingInvocation $MyInvocation;
}
