$script:WorkingDir = $PSScriptRoot;
$script:TaskName = 'adotaskname'
$script:Description = 'This task generates a complex password'
$script:Author = 'Jeffrey S. Patton'

Task clean {
 Remove-Item "$($script:WorkingDir)\Output" -Recurse -ErrorAction Ignore;
 New-Item -Name "Output" -ItemType Directory -Force;
}

Task SetupTfx {
 npm install -g tfx-cli
}

Task SetupTask -depends SetupTfx {
 tfx build tasks create --task-name $script:TaskName --friendly-name $script:TaskName --description $script:Description --author $script:Author
}

Task AddVstsTaskSdk -depends SetupTask {
 Save-Module –Name VstsTaskSdk –Path ".\$($script:TaskName)\ps_modules" –Force
}

Task CreatePackage -depends Clean {
 tfx extension create --manifest-globs vss-extension.json --output-path "$($script:WorkingDir)\Output"
}