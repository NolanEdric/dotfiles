param([Parameter(Mandatory)] $ip, [switch]$Elevated)


function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

if ((Test-Admin) -eq $false) {
  if ($elevated) {
    # tried to elevate, did not work, aborting
  } 
  else {
    Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -noexit -file "{0}" -elevated -ip "{1}"' -f ($myinvocation.MyCommand.Definition, $ip)) 2>$null
  }

  exit
}

'running with full privileges'

$hosts = "C:\Windows\System32\drivers\etc\hosts"
$host_name = "wsl"

$START_PATTERN = "# Added by TiDu for WSL"
$END_PATTERN = "# Added by TiDu for WSL"

("$(Get-Content $hosts -Raw) " -replace "(?<=$START_PATTERN\n)([\s\S]*?)(?=$END_PATTERN)", "").Trim() | Out-File -Encoding ASCII $hosts

"$START_PATTERN`n$ip`t$host_name`n$END_PATTERN" | Out-File -Encoding ASCII -Append $hosts

wsl -- sudo sed -i "/^$START_PATTERN/,/^$END_PATTERN/d" /etc/hosts

$cmdx = "echo '$START_PATTERN\n$ip\t$host_name\n$END_PATTERN' | sudo tee -a /etc/hosts"
wsl -- eval($cmdx)
