$config_file = "$PSScriptRoot/ip.json"
$updater = "$PSScriptRoot/ddns.exe"
$provider = "dynu"

$ip = (Get-Content $config_file -Raw) | ConvertFrom-Json

$ipv4 = ((Get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress).Trim()
$ipv6 = ((Get-NetIPAddress -AddressFamily IPv6 -InterfaceAlias Ethernet -PrefixLength 128 -PrefixOrigin RouterAdvertisement -SuffixOrigin Random).IPAddress).Trim()
$wsl = (wsl echo '$IPv4').Trim()

if ($ipv4 -ne $ip.ipv4) {
    # & $updater -s "$provider" -c $ipv4
    & $updater -s "$provider" -c $ipv4 -p "*."
    $ip.ipv4 = $ipv4
}

if ($ipv6 -ne $ip.ipv6) {
    # & $updater -s "$provider" -c $ipv6 -t AAAA
    & $updater -s "$provider" -c $ipv6 -t AAAA -p "*."
    $ip.ipv6 = $ipv6
}

if ($wsl -ne $ip.wsl) {
    # & $updater -s dynu -c $wsl
    & $updater -s "$($provider)_simple" -c $wsl -p "*."
    $ip.wsl = $wsl
}

$ip | ConvertTo-Json | Set-Content $config_file
