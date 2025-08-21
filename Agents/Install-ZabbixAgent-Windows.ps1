<# 
Zabbix Agent 7.0 - Installation automatique Windows (PowerShell)
Exécution (en admin):
  powershell.exe -ExecutionPolicy Bypass -File .\Install-ZabbixAgent-Windows.ps1 -ServerIP 192.168.1.104 -Hostname WIN11 -MsiUrl https://cdn.zabbix.com/zabbix/binaries/stable/7.0/7.0.0/zabbix_agent-7.0.0-windows-amd64-openssl.msi
#>

param(
  [Parameter(Mandatory=$true)] [string]$ServerIP,
  [Parameter(Mandatory=$false)] [string]$Hostname = $env:COMPUTERNAME,
  [Parameter(Mandatory=$false)] [string]$MsiUrl = "https://cdn.zabbix.com/zabbix/binaries/stable/7.0/7.0.0/zabbix_agent-7.0.0-windows-amd64-openssl.msi",
  [Parameter(Mandatory=$false)] [string]$TlsPsk = "",
  [Parameter(Mandatory=$false)] [string]$TlsPskIdentity = ""
)

$ErrorActionPreference = "Stop"
$msiPath = "$env:TEMP\zabbix_agent.msi"

Write-Host "[1/5] Téléchargement de l'agent : $MsiUrl"
Invoke-WebRequest -Uri $MsiUrl -OutFile $msiPath

# Arguments MSI
$msiArgs = @(
  "/i `"$msiPath`"",
  "SERVER=$ServerIP",
  "SERVERACTIVE=$ServerIP",
  "HOSTNAME=$Hostname",
  "ENABLEPATH=1",
  "INSTALLFOLDER=`"C:\Program Files\Zabbix Agent`"",
  "/qn", "/norestart"
)

if ($TlsPsk -and $TlsPskIdentity) {
  # config TLS PSK via MSI properties non standard -> post-config dans zabbix_agentd.conf
  Write-Host "[2/5] ➤ TLS PSK détecté, config sera appliquée après installation"
}

Write-Host "[2/5] Installation silencieuse MSI"
$process = Start-Process "msiexec.exe" -ArgumentList ($msiArgs -join " ") -Wait -PassThru
if ($process.ExitCode -ne 0) {
  throw "L'installation MSI a échoué avec le code $($process.ExitCode)"
}

# Post-configuration (TLS PSK si fourni)
$configPath = "C:\Program Files\Zabbix Agent\zabbix_agentd.conf"
if (Test-Path $configPath) {
  (Get-Content $configPath) `
    -replace '^\s*Server=.*', "Server=$ServerIP" `
    -replace '^\s*ServerActive=.*', "ServerActive=$ServerIP" `
    -replace '^\s*Hostname=.*', "Hostname=$Hostname" | Set-Content $configPath

  if ($TlsPsk -and $TlsPskIdentity) {
    Add-Content $configPath "TLSConnect=psk"
    Add-Content $configPath "TLSAccept=psk"
    Add-Content $configPath "TLSPSKIdentity=$TlsPskIdentity"
    $pskFile = "C:\Program Files\Zabbix Agent\zabbix_agentd.psk"
    Set-Content -Path $pskFile -Value $TlsPsk -NoNewline
    $acl = Get-Acl $pskFile
    $acl.SetAccessRuleProtection($true, $false)
    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrators","FullControl","Allow")
    $acl.SetAccessRule($rule)
    Set-Acl $pskFile $acl
    Add-Content $configPath "TLSPSKFile=$pskFile"
  }
}

Write-Host "[3/5] Démarrage du service"
Start-Service "Zabbix Agent" -ErrorAction SilentlyContinue
Set-Service -Name "Zabbix Agent" -StartupType Automatic

Write-Host "[4/5] Pare-feu Windows : ouverture du port 10050 (TCP)"
Try {
  New-NetFirewallRule -DisplayName "Zabbix Agent 10050" -Direction Inbound -Protocol TCP -LocalPort 10050 -Action Allow -ErrorAction Stop | Out-Null
} Catch { Write-Host "Règle déjà présente ou non créée: $($_.Exception.Message)" }

Write-Host "[5/5] - Installation Terminé. Vérifiez l'hôte dans le serveur Zabbix: $Hostname"
