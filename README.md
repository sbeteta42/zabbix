# ![Zabbix Logo](https://www.laintimes.com/wp-content/uploads/2017/05/zabbix-logo.png) 
# 💻 Supervision & Monitoring Réseau 

![OS](https://img.shields.io/badge/OS-Debian%20|%20Ubuntu%20|%20CentOS-blue)
![Status](https://img.shields.io/badge/Status-Lab%20Ready-success)
![License](https://img.shields.io/badge/License-AGPL--3.0-red)
![Stack](https://img.shields.io/badge/Stack-Zabbix%20Server%20|%20Agent%20|%20Web-orange)

---

## 📑 Table des matières
1. [Présentation](#-présentation)
2. [Fonctionnalités](#-fonctionnalités)
3. [Installation](#-installation)
4. [Configuration rapide](#-configuration-rapide)
5. [Usage basique](#-usage-basique)
6. [Support & Documentation](#-support--documentation)
7. [Licence](#-licence)

---

## 📖 Présentation
**Zabbix** est une solution Open Source de supervision en temps réel, parfaite pour surveiller l’état des équipements réseau, serveurs, applications, etc.

---

## 🚀 Fonctionnalités
- 🔍 Découverte automatique de ressources (serveurs, VM, services)
- 📊 Collecte d’indicateurs via agent ou sans agent
- ⚠️ Détection d’anomalies et corrélation d’événements
- 📢 Alertes en temps réel (email, Slack, Teams…)
- 🗺️ Interface visuelle riche (graphiques, cartes réseau, dashboards)
- 🌐 Surveillance distribuée multi-tenants

---

## ⚙️ Installation
```bash
git clone https://github.com/sbeteta42/zabbix.git
cd zabbix
# Exécuter le script d’installation
chmod +x install_zabbix_debian12.sh
./install_zabbix_debian12.sh
```
---

## 🔧 Configuration rapide
- Accéder à l’interface web Zabbix
- Ajouter un agent Linux/Windows
- Appliquer un template prédéfini à un hôte
- Surveiller les métriques (CPU, mémoire, réseau…)

## 🖥️ Usage basique
UI Web : http://$SERVER_IP/zabbix
## 🌐 Accès à l'interface Web
URL après installation :

http://$SERVER_IP/zabbix

Identifiants par défaut :
```
Utilisateur : Admin
Mot de passe : zabbix
```
## 🔐 Vérifications post-installation
- `systemctl status zabbix-server zabbix-agent apache2`
- Vérifier l’accès Web et terminer l’assistant
- Ajuster le fuseau horaire PHP/Apache si nécessaire
- Faire un `dkpg-reconfigure locales` et sélectionner "all" ; choisir ensuite la langue de votre OS en cours

## 💡 Dépannage rapide
- Problème d'accès Web : vérifier le port 80 (firewall, NAT)
- Erreur DB `Access denied` : contrôler `DB_USER`, `DB_PASS`, `DB_NAME`
- Agent non visible : vérifier `/etc/zabbix/zabbix_agentd.conf` (Server, ServerActive, Hostname)

## 📦 Contributions
PR et issues bienvenues. Proposez vos améliorations, templates additionnels, ou scripts agents auto.

## 📚 Support & Documentation
Documentation officielle : https://www.zabbix.com/documentation

## 📜 Licence
Zabbix est distribué sous licence AGPL-3.0.
