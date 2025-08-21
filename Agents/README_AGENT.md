# Installation de l'agent Zabbix

## 📌 Description
Ce script installe et configure automatiquement un **agent Zabbix 7.0** sur un hôte Debian/Ubuntu pour être supervisé par un serveur Zabbix.

## 📋 Prérequis
- Système : Debian 12 / Ubuntu
- Accès root ou sudo
- IP du serveur Zabbix connue
- Port 10050 ouvert (TCP) sur le client et le serveur

## 🚀 Utilisation

1. **Télécharger le script**
```bash
wget https://raw.githubusercontent.com/<ton-user>/<ton-repo>/main/install_zabbix_agent_debian.sh
chmod +x install_zabbix_agent_debian.sh
```

2. **Modifier l'IP du serveur Zabbix** dans le script si nécessaire :
```bash
ZBX_SERVER_IP="192.168.1.100"
```

3. **Exécuter le script**
```bash
sudo ./install_zabbix_agent_debian.sh
```

## 🌐 Vérification
- Vérifier le statut du service :
```bash
systemctl status zabbix-agent
```
- Dans l'interface Zabbix, ajouter l'hôte avec :
  - **Hostname** : celui du client
  - **Template** : Linux by Zabbix agent active

## 📜 Licence
MIT — voir le fichier [LICENSE](LICENSE).
