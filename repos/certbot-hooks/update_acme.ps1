# dir env: | Out-File "env.txt" -Encoding ASCII

# $loc = Get-Location
# Set-Location "$HOME\repos\ddns"
# $updater = ".\ddns.exe"
# Set-Location $loc
# & $updater -s "$env:provider" -c $env:CERTBOT_VALIDATION -p="$acme.$subdomain" -t TXT
Start-Sleep -s 30
$acme = "_acme-challenge"
$nodeName = $acme
if ($env:CERTBOT_DOMAIN -ne $env:domain) {
    $subdomain =  $env:CERTBOT_DOMAIN.substring(0, $env:CERTBOT_DOMAIN.indexOf($env:domain) - 1)
    $nodeName = "$acme.$subdomain"
}

# dir env: | out-file -Encoding ASCII a

write-host $nodeName

$headers = @{
    "Content-Type" = "application/json";
    "API-Key" = $env:apikey
}

$body = @{
  nodeName = $nodeName;
  recordType = "TXT";
  ttl = 0;
  state = $true;
  group = "";
  textData = $env:CERTBOT_VALIDATION
}

$res = iwr "https://api.dynu.com/v2/dns/${env:domain_id}/record" -Method Post -Headers $headers -Body ($body|ConvertTo-Json)
(ConvertFrom-Json $res).id | Out-File -Append -Encoding ASCII -FilePath "$env:temp\acme_record_id"


While ((Resolve-DnsName -Type TXT -ErrorAction SilentlyContinue "$acme.$env:CERTBOT_DOMAIN").Strings -notcontains "$env:CERTBOT_VALIDATION") {
    Write-Host "DNS does not match. Retrying in 5s"
    ipconfig /flushdns
    Start-Sleep -s 5
}

Write-Host "DNS matched. Done"
Start-Sleep -s 30
