# GLPI avec le plugin GLPI Inventory (Et plus FUSION INVENTORY !

## 🧰 GLPI – Installation & Utilisation##   

![OS](https://img.shields.io/badge/OS-Debian%2011%2F12%20|%20Ubuntu%2020.04%2F22.04-blue)  
![Status](https://img.shields.io/badge/Status-Lab%20Ready-success)  
![License](https://img.shields.io/badge/License-MIT-green)  
![Stack](https://img.shields.io/badge/Stack-PHP%20|%20MariaDB%20|%20Nginx%2FApache-orange)  

## 📦 Pré-requis  
- **OS** : Debian 11/12 ou Ubuntu 20.04/22.04  
- **Paquets nécessaires** : `nginx` ou `apache2`, `mariadb-server`, `php`, `git`, `curl`  
- Accès SSH à la machine
  
## ⚙️ Installation rapide  
1️⃣ **Connexion à la VM**  
```bash
ssh user@<glpi_ip>
```
2️⃣ Passer en root

```bash
su -
```
3️⃣ Installation via script

```bash
curl -fsSL https://raw.githubusercontent.com/sbeteta42/glpi/main/install.sh | bash
```
🌐 Accès à GLPI
Depuis le LAN :
http://<glpi_ip>/

🛠️ Post-installation
🔒 Changer les mots de passe par défaut

🗑️ Supprimer le dossier /install

🔐 Configurer HTTPS si nécessaire

💾 Mettre en place une sauvegarde régulière de la base et des fichiers

📄 Documentation
🌍 Site officiel GLPI
