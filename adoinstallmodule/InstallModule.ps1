[CmdletBinding()]
param()

[string]$Name = Get-VstsInput -Name Name
[string]$Scope = Get-VstsInput -Name Scope
[boolean]$AllowClobber = Get-VstsInput -Name AllowClobber -AsBool

$Scopes = @('AllUsers','CurrentUser');

if (!($Scopes.Contains($Scope)))
{
 $Scope = 'CurrentUser';
}

if ($AllowClobber)
{
 Install-Module -Name $Name -Scope $Scope -AllowClobber -Force;
} else
{
 Install-Module -Name $Name -Scope $Scope;
}

Get-Command -Module $Name;