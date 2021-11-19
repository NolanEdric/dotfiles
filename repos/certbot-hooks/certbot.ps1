# $env:REQUESTS_CA_BUNDLE= "$(mkcert -CAROOT)\ca.crt"
$env:domain = "tidu.giize.com"
$env:provider = "dynu"

certbot certonly `
  --agree-tos `
  --manual `
  --email tidunguyen@aol.com `
  --preferred-challenges=dns `
  --server https://acme-v02.api.letsencrypt.org/directory `
  -d "*.kube.$env:domain" `
  -d "kube.$env:domain" `
  --manual-auth-hook "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass C:/Users/TiDu/repos/certbot-hooks/update_acme.ps1" `
  --manual-cleanup-hook "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass C:/Users/TiDu/repos/certbot-hooks/cleanup_acme.ps1" `
  --post-hook "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -executionpolicy bypass C:/Users/TiDu/repos/certbot-hooks/post_hook.ps1"

  # -d *.k3s.tidu.live `
  # --pre-hook "C:\ProgramData\chocolatey\bin\nssm.exe stop nginx" `
  # --post-hook "C:\ProgramData\chocolatey\bin\nssm.exe start nginx"
# certonly
  # -d *.k8s.tidu.live `
  # --non-interactive `
  # --nginx `
  # --nginx-server-root "D:\nginx\latest" `
  # --nginx-ctl "D:\nginx\latest\nginx.exe" `
  # --server https://api.buypass.com/acme/directory `
  # --server https://ca.tidu.live/acme/acme/directory `
