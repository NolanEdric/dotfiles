Import-Module posh-git
Import-Module oh-my-posh
Import-Module -Name Terminal-Icons
Set-PoshPrompt -Theme powerlevel10k_modern

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

Get-ChildItem "$HOME\completions\*.ps1" | ForEach-Object {
  . $_.FullName
}

$env:BW_SESSION="qZODrAUW8unBmpitK292BaW0RKCcHIsJtxqdRWQiWQSzGo9g+omQWGWJ3lRViyAzWMAwM5kgQ3feC2UvXer6ZQ=="
$env:MICRO_TRUECOLOR=1
