# Agents Zabbix (Linux Debian 12 & Windows)

Ce dossier contient des scripts pour déployer rapidement des **agents Zabbix 7.0** en mode actif/passif.

## Debian 12

### Script
- `install_zabbix_agent_debian12.sh`

### Usage
```bash
sudo ./install_zabbix_agent_debian12.sh -s 192.168.1.104 -h srv-linux-01
# Avec TLS PSK :
sudo ./install_zabbix_agent_debian12.sh -s 192.168.1.104 -h srv-linux-01 -p <PSK_HEX> -n "PSK-SRV-LINUX-01"
```

Le script :
- ajoute le dépôt Zabbix 7.0,
- installe `zabbix-agent`,
- configure `Server`, `ServerActive`, `Hostname`,
- (option) active **TLS PSK** si `-p` et `-n` sont fournis,
- démarre et active le service.

## Windows (PowerShell)

### Script
- `Install-ZabbixAgent-Windows.ps1`

### Usage (Admin)
```powershell
powershell.exe -ExecutionPolicy Bypass -File .\Install-ZabbixAgent-Windows.ps1 -ServerIP 192.168.1.104 -Hostname WIN11 `
  -MsiUrl https://cdn.zabbix.com/zabbix/binaries/stable/7.0/7.0.0/zabbix_agent-7.0.0-windows-amd64-openssl.msi
# Avec TLS PSK :
powershell.exe -ExecutionPolicy Bypass -File .\Install-ZabbixAgent-Windows.ps1 -ServerIP 192.168.1.104 -Hostname WIN11 `
  -TlsPsk <PSK_HEX> -TlsPskIdentity "PSK-WIN11"
```

Remarques :
- Ajustez l’URL `-MsiUrl` si une nouvelle version 7.0.x est publiée.
- Le script ouvre le port **10050/TCP** dans le pare-feu Windows.
- Le service **Zabbix Agent** est mis en **Automatic** et démarré.

## Bonnes pratiques
- Préférez le mode **actif** (templates `* by Zabbix agent active`) pour les hôtes distants/NAT.
- Utilisez **TLS PSK** ou **certificats** en production.
- Enregistrez/liez automatiquement les hôtes avec des **Actions** côté serveur (conditions + opérations).
