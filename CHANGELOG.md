# Changelog

All changes to this module should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [[1.2.2]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.2.2) - 2022-12-29

BUGFIX, when passing in boolean values from ADO, you need to use the -AsBool switch for Get-VstsInput. For future reference there is also a switch for Integers (-AsInt)

The following changes have been applied:

- InstallModule.ps1
  - Added -AsBool switch for AllowClobber parameter

--

## [[1.2.1]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.2.1) - 2022-12-29

Minor update, the move was moving the versioned folder, updated the task to move the contents.

The following changes have been applied:

- psakefile.ps1
  - Updated the task to move the files up one level

--

## [[1.2.0]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.2.0) - 2022-12-29

This update includes a fix for the file not found error, the VstsTaskSdk Module needs to be one level below the task. When you perform the Save-Module command it creates a versioned folder below the VstsTaskSdk folder and all the PowerShell goes there.

The following changes have been applied:

- psakefile.ps1
  - Updated the task to move the files up one level
- ps_modules
  - Moved the module files up one level

--

## [[1.1.0]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.1.0) - 2022-12-29

This update includes a fix for the file not found error as well as a UI update for Scope

The following changes have been applied:

- ps_modules
  - removed from .gitignore
- task.json
  - Scope Property
    - Changed from String to Picklist

--

## [[1.0.0]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.0.0) - 2022-12-29

This is the initial release of the Install Module task. It will allow you to install a powershell module from a task in your Azure DevOps pipelines.

--
