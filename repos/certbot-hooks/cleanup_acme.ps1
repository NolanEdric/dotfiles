# $loc = Get-Location
# Set-Location "$HOME\repos\ddns"
# $updater = ".\ddns.exe"
# Set-Location $loc

# $subdomain =  $env:CERTBOT_DOMAIN.substring(0, $env:CERTBOT_DOMAIN.indexOf($env:domain))
# $acme = "_acme-challenge"

# & $updater -s "$env:provider" -p="$acme.$subdomain" -t TXT -d

$f = "$env:temp\acme_record_id"
$record_id = get-content $f -Head 1

if ("$record_id" -ne "") {
  $acme = "_acme-challenge"
  $nodeName = $acme
  if ($env:CERTBOT_DOMAIN -ne $env:domain) {
      $subdomain =  $env:CERTBOT_DOMAIN.substring(0, $env:CERTBOT_DOMAIN.indexOf($env:domain) - 1)
      $nodeName = "$acme.$subdomain"
  }

  $headers = @{
      "API-Key" = $env:apikey
  }

  iwr "https://api.dynu.com/v2/dns/${env:domain_id}/record/${record_id}" -Method Delete -Headers $headers
}

$new_content = (Get-Content $f | Select-Object -Skip 1)

if ("$new_content" -eq "") {
  Remove-Item $f
} else {
  $new_content | Out-File $f
}
