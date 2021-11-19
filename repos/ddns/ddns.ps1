. "$PSScriptRoot/CloudflareDNS.ps1"

$WSL_IP = wsl hostname -I
$IPv6 = (Get-NetIPAddress -AddressFamily IPv6 -InterfaceAlias Ethernet -SuffixOrigin Link -PrefixOrigin RouterAdvertisement).IPAddress
$IPv4 = (Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress

$WSL_PREFIX = "wsl"

$cloudflareDNS = [CloudflareDNS]::new()

$cloudflareDNS.Update($IPv4, "A", "")
$cloudflareDNS.Update($IPv4, "A", "*.")
$cloudflareDNS.Update($IPv6, "AAAA", "")
$cloudflareDNS.Update($IPv6, "AAAA", "*.")
# $cloudflareDNS.Update($WSL_IP, "A", "$WSL_PREFIX.")
# $cloudflareDNS.Update($WSL_IP, "A", "*.$WSL_PREFIX.")
