# dir env: | Out-File "env.txt" -Encoding ASCII

$loc = Get-Location
Set-Location "$HOME\repos\ddns"
$updater = ".\ddns.exe"

$subdomain =  $env:CERTBOT_DOMAIN.substring(0, $env:CERTBOT_DOMAIN.indexOf($env:domain))
$acme = "_acme-challenge"

Start-Sleep -s 60
& $updater -s "$env:provider" -c $env:CERTBOT_VALIDATION -p="$acme.$subdomain" -t TXT

Set-Location $loc

While ((dig -t TXT "$acme.$env:CERTBOT_DOMAIN" +noall +answer +short) -ne "`"$env:CERTBOT_VALIDATION`"") {
    Write-Host "DNS does not match. Retrying in 5s"
    ipconfig /flushdns
    Start-Sleep -s 5
}

Write-Host "DNS matched. Done"
