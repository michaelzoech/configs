function prompt {
    $origLastExitCode = $LASTEXITCODE
    Write-Host -NoNewline $ExecutionContext.SessionState.Path.CurrentLocation
    Write-VcsStatus
    Write-Host
    $LASTEXITCODE = $origLastExitCode
    "$('>' * ($nestedPromptLevel + 1)) "
}

Import-Module posh-git
