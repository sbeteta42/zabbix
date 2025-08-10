# 🚀 Script d'installation automatique de Zabbix 7.0 LTS sur Debian 12

![Zabbix Logo](https://assets.zabbix.com/img/logo/zabbix_logo_500x131.png)

## 📌 Description
Ce script Bash installe et configure automatiquement **Zabbix 7.0 LTS** sur **Debian 12.5** avec **MariaDB** et l’interface Web.  
Il est basé sur les bonnes pratiques décrites dans la documentation et permet de déployer un serveur Zabbix fonctionnel en quelques minutes.

---

## 🛠️ Fonctionnalités
- Installation des paquets nécessaires (Zabbix server, frontend PHP, agent, MariaDB)
- Configuration et sécurisation de la base de données
- Importation du schéma SQL de Zabbix
- Configuration automatique du mot de passe BDD dans `zabbix_server.conf`
- Démarrage et activation des services
- Message de fin avec URL et identifiants par défaut

---

## 📂 Fichiers
- `install_zabbix_debian12.sh` → Script principal d’installation

---

## 📋 Prérequis
- **Debian 12.5** (ou compatible)
- Connexion Internet
- Accès root ou utilisateur avec droits `sudo`
- Port 80 ouvert pour l’interface Web

---

## 🚀 Installation

1. **Télécharger le script**
```bash
wget https://raw.githubusercontent.com/sbeteta42/zabbix/main/install_zabbix_debian12.sh
chmod +x install_zabbix_debian12.sh
