# Changelog

All changes to this module should be reflected in this document.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [[1.3.2]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.3.2) - 2024-07-05

This version adds some additional checks and verbose output to validate that the version exists in the Gallery.

1. **Check if the module is already installed and matches the required version:**
   - Added a check to see if the module is installed.
   - If installed, compare the installed version with the required version.
   - Skip the installation if the installed version matches the required version.

2. **Verbose logging for installed module status:**
   - Log a message if the module is already installed with the required version.
   - Log a message if the module is installed but the version does not match the required version.
   - Log a message if the module is not installed.

3. **Check if the specified version is available:**
   - Ensure the specified version is available in the repository before attempting to install it.
   - Throw an error if the specified version is not available.

4. **Install the module only if the required version is not already installed:**
   - Proceed with the installation if the required version is not already installed.
   - Verify the installation and log the installed version.

--

## [[1.3.1]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.3.1) - 2024-05-09

This is a minor and much needed update to allow a version to be passed into the task.

The following changes have been applied:

- InstallModule.ps1
  - Added Version parameter

--

## [[1.3.0]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.3.0) - 2022-12-30

This update makes the Task public as well as provides some output while it's running. Making an extension public requires having an overview.md file and an icon.

The following changes have been applied:

- vss-extension.json
  - Added GalleryFlags
  - Added Links
  - Added Repository
- InstallModule.ps1
  - Removed Scope logic as it's a picklist now
  - Added WriteVerbose output
  - Added WriteHost output
  - Added light error handling
- Overview.md
  - Added this file
- icon.png
  - Added this file

--

## [[1.2.3]](https://github.com/PoshAdoTasks/ado-installmodule/releases/tag/v1.2.3) - 2022-12-29

BUGFIX, the task.json had the defaultValue of "true" for AllowClobber

The following changes have been applied:

- task.json
  - Removed quotes from true

--

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
