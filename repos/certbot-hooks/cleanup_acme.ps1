$loc = Get-Location
Set-Location "$HOME\repos\ddns"
$updater = ".\ddns.exe"

$subdomain =  $env:CERTBOT_DOMAIN.substring(0, $env:CERTBOT_DOMAIN.indexOf($env:domain))
$acme = "_acme-challenge"

& $updater -s "$env:provider" -p="$acme.$subdomain" -t TXT -d

Set-Location $loc
