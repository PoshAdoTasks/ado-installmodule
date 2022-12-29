$script:WorkingDir = $PSScriptRoot;
$script:GithubRepo = 'ado-installmodule'
$script:TaskName = $script:GithubRepo.Replace('-','')
$script:Description = 'An Azure DevOps PowerShell Task to install a module'
$script:Author = 'Jeffrey S. Patton'
$script:GithubUrl = "https://github.com/PoshAdoTasks/$($script:GithubRepo)"
$script:MarketplaceUrl = "https://marketplace.visualstudio.com/items?itemName=pattontech.$($script:TaskName)"

Task CreateAdoTask -depends Clean, AddVstsTaskSdk

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

Task NewTaggedRelease -Description "Create a tagged release" -Action {
 $Version = Get-Content "$($script:WorkingDir)\vss-extension.json" |ConvertFrom-Json |Select-Object -ExpandProperty Version
 git tag -a v$version -m "$($script:TaskName) Version $($Version)"
 git push origin v$version
}

Task Post2Discord -Description "Post a message to discord" -Action {
 $version = Get-Content "$($script:WorkingDir)\vss-extension.json" |ConvertFrom-Json |Select-Object -ExpandProperty Version
 $Discord = Get-Content .\discord.poshmongo | ConvertFrom-Json
 $Discord.message.content = "Version $($version) of $($script:TaskName) released. Please visit Github ($script:GithubUrl) or the MarketPlace ($script:MarketplaceUrl) to download."
 Invoke-RestMethod -Uri $Discord.uri -Body ($Discord.message | ConvertTo-Json -Compress) -Method Post -ContentType 'application/json; charset=UTF-8'
}
