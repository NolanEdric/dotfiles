
# dir env: | Out-File "env.txt" -Encoding ASCII

$outdir = $env:CERTBOT_ALL_DOMAINS.Split(',')[0]

if ([string]::IsNullOrWhitespace($outdir)) {
  exit
}

$cert = (get-content "C:\Certbot\live\$outdir\fullchain.pem")
$key = (get-content "C:\Certbot\live\$outdir\privkey.pem")

Remove-Item -Recurse ".\live\$outdir"
mkdir ".\live\$outdir"

$cert | Out-File -Encoding ASCII ".\live\$outdir\tls.crt"
$key | Out-File -Encoding ASCII ".\live\$outdir\tls.key"
$cert, $key | Out-File -Encoding ASCII ".\live\$outdir\tls.pem"

Start-Sleep 1

# "C:\Windows\System32\wsl.exe -- sudo systemctl restart haproxy"
