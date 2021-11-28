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

$env:BW_SESSION="6OQirQdZOFd/DUydBqjkE+7m/iEmWCYXyncE4urdfhc2kQiJgach6gmdQRC3TXR3cNJ8V5QMgyAyAu1VWSXUdg=="
$env:MICRO_TRUECOLOR=1
