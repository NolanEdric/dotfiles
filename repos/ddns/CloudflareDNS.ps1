. "$PSScriptRoot/ConfigManager.ps1"

class CloudflareDNS {
    [Object] $config
    [string] $config_file

    CloudflareDNS([ConfigManager] $cm) {
        $this.config_file = "$PSScriptRoot/ddns_config.json"
        $this.loadConfig()
    }

    CloudflareDNS([string] $config_file) {
        $this.loadConfig()
    }

    [void] loadConfig() {
        $this.config = ((Get-Content $this.config_file -Raw) | ConvertFrom-Json).cloudflare
        if ($null -eq $this.config.zone_id) {
            Write-Host "No Zone Id"
            $this.config.zone_id = $this.ZoneId()
            $this.saveConfig()
        }

        if ($null -eq $this.config.record_list) {
            Write-Host "No Records"
            $this.config.record_list = $this.RecordList()
            $this.saveConfig()
        }
    }

    [void] saveConfig() {
        $current_config = (Get-Content $this.config_file -Raw) | ConvertFrom-Json
        $current_config.cloudflare = $this.config
        $current_config | ConvertTo-Json -depth 100 | Set-Content $this.config_file
    }

    [string] ZoneId() {
        return (Invoke-WebRequest `
                -Uri "$($this.config.endpoint)/zones?name=$($this.config.zone)" `
                -Headers @{"Authorization" = "Bearer $($this.config.token)" } `
            | ConvertFrom-Json
        ).result.id
    }

    [Object] RecordList() {
        return (Invoke-WebRequest `
                -Method GET `
                -Uri "$($this.config.endpoint)/zones/$($this.config.zone_id)/dns_records" `
                -Headers @{"Authorization" = "Bearer $($this.config.token)" } `
            | ConvertFrom-Json).result
    }

    [void] Update(
        $IP,
        $type,
        $subdomain
    ) {
        $record = ($this.config.record_list | Where-Object { $_.name -EQ "$subdomain$($this.config.zone)" -and $_.type -EQ $type })
        if ($record.content -ne $IP) {
            Write-Host "Updating $subdomain$($this.config.zone) to IP: $IP"
            Invoke-WebRequest `
                -Method PUT `
                -Uri "$($this.config.endpoint)/zones/$($record.zone_id)/dns_records/$($record.id)" `
                -Headers @{"Authorization" = "Bearer $($this.config.token)"; "Content-Type" = "application/json" } `
                -Body (@{type = $type; name = "$subdomain$($this.config.zone)"; content = $IP; ttl = 1 } | ConvertTo-Json)
            $record.content = $IP
            $this.saveConfig()
        }
        else {
            Write-Host "$subdomain$($this.config.zone) resolves to IP: $($record.content). Skip updating DNS."
        }
    }
}
