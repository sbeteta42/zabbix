#!/bin/bash
# Zabbix Agent 7.0 - Installation automatique sur Debian 12
# Usage: sudo ./install_zabbix_agent_debian12.sh -s <IP_SERVEUR_ZABBIX> -h <HOSTNAME> [-p <PSK_HEX>] [-n <PSK_ID>]
# Par sbeteta@beteta.org
set -e

SERVER_IP=""
HOSTNAME="$(hostname -f)"
TLS_PSK=""
TLS_PSK_ID=""

while getopts "s:h:p:n:" opt; do
  case $opt in
    s) SERVER_IP="$OPTARG" ;;
    h) HOSTNAME="$OPTARG" ;;
    p) TLS_PSK="$OPTARG" ;;
    n) TLS_PSK_ID="$OPTARG" ;;
    *) echo "Usage: $0 -s <IP_SERVEUR_ZABBIX> -h <HOSTNAME> [-p <PSK_HEX>] [-n <PSK_ID>]" ; exit 1 ;;
  esac
done

if [ -z "$SERVER_IP" ]; then
  echo "Erreur: -s <IP_SERVEUR_ZABBIX> est obligatoire."
  exit 1
fi

echo "[1/6] ➤ Ajout du dépôt Zabbix 7.0..."
wget -q https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1+debian12_all.deb
dpkg -i zabbix-release_7.0-1+debian12_all.deb
apt update -y

echo "[2/6] ➤ Installation de zabbix-agent..."
apt install -y zabbix-agent

CFG="/etc/zabbix/zabbix_agentd.conf"
echo "[3/6] ➤ Configuration de l'agent dans $CFG"
sed -i "s/^#\?Hostname=.*/Hostname=${HOSTNAME}/" "$CFG"
sed -i "s/^#\?Server=.*/Server=${SERVER_IP}/" "$CFG"
sed -i "s/^#\?ServerActive=.*/ServerActive=${SERVER_IP}/" "$CFG"

if [ -n "$TLS_PSK" ] && [ -n "$TLS_PSK_ID" ]; then
  echo "[3b] ➤ Configuration TLS PSK"
  sed -i "s/^#\?TLSConnect=.*/TLSConnect=psk/" "$CFG"
  sed -i "s/^#\?TLSAccept=.*/TLSAccept=psk/" "$CFG"
  sed -i "s/^#\?TLSPSKIdentity=.*/TLSPSKIdentity=${TLS_PSK_ID}/" "$CFG"
  # Stocker la PSK dans un fichier protégé
  echo "${TLS_PSK}" > /etc/zabbix/zabbix_agentd.psk
  chmod 600 /etc/zabbix/zabbix_agentd.psk
  sed -i "s|^#\?TLSPSKFile=.*|TLSPSKFile=/etc/zabbix/zabbix_agentd.psk|" "$CFG"
fi

echo "[4/6] ➤ Activation et démarrage de l'agent"
systemctl enable zabbix-agent
systemctl restart zabbix-agent

echo "[5/6] ➤ Statut:"
systemctl --no-pager --full status zabbix-agent || true

echo "[6/6] - Installation Terminé. Vérifiez dans le serveur Zabbix l'hôte: ${HOSTNAME}"
