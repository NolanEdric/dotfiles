Import-Module posh-git
Import-Module oh-my-posh
Set-PoshPrompt -Theme iterm2

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

$env:BW_SESSION="9ugAleOixlubpdTbLrmW+RCLlqZ2Axlh7CMNfUtXVfG5nVoPUwEO9whgAt5wRAqOa0bK+Ky7956AScgYwWFzfw=="
$env:MICRO_TRUECOLOR=1
