# Define the path to monitor and the command to run
$Path = "src"
$Command = "make"

# Set up the watcher
$Watcher = New-Object System.IO.FileSystemWatcher
$Watcher.Path = $Path
$Watcher.Filter = "*.c"
$Watcher.IncludeSubdirectories = $true
$Watcher.EnableRaisingEvents = $true

# Define the action to take on file change
$Action = {
    Write-Host "File changed: $($EventArgs.FullPath)"
    Invoke-Expression $Command
}

# Bind events
$OnChanged = Register-ObjectEvent $Watcher Changed -Action $Action
$OnCreated = Register-ObjectEvent $Watcher Created -Action $Action
$OnDeleted = Register-ObjectEvent $Watcher Deleted -Action $Action
$OnRenamed = Register-ObjectEvent $Watcher Renamed -Action $Action

# Keep the script running
Write-Host "Watching for changes in '$Path'. Press Ctrl+C to exit."
while ($true) {
    Start-Sleep -Seconds 1
}
