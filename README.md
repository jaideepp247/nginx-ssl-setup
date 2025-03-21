# Nginx SSL Auto-Setup Script

This Bash script automates the installation and configuration of Nginx with SSL (Let's Encrypt) on an Ubuntu server. It prompts the user for a domain name and port, then sets up everything required for a secure web server.

## Features
- Installs **Nginx** and **Certbot** (Let's Encrypt SSL)
- Configures Nginx for the provided domain and port
- Automatically obtains and sets up an SSL certificate
- Sets up automatic SSL renewal

## Prerequisites
- Ubuntu-based server (tested on Ubuntu 20.04+)
- A valid domain name pointing to your server's IP
- **sudo** or root access

## Installation & Usage
To run the script directly from GitHub:

```bash
bash <(curl -s https://raw.githubusercontent.com/jaideepp247/nginx-ssl-setup/main/setup.sh)
```

### Manual Installation
If you prefer to clone the repository manually:

```bash
git clone https://github.com/jaideepp247/nginx-ssl-setup.git
cd nginx-ssl-setup
chmod +x setup.sh
sudo ./setup.sh
```

## How It Works
1. The script prompts for a **domain name** and **port**.
2. Installs required packages (Nginx, Certbot, UFW, etc.).
3. Configures Nginx with the provided domain and port.
4. Requests an SSL certificate from Let's Encrypt.
5. Sets up a cron job for SSL certificate auto-renewal.

## Troubleshooting
- If the script fails to obtain an SSL certificate, ensure that **port 80 and 443** are open in your firewall.
- Run `sudo certbot renew --dry-run` to test SSL renewal.
- Check Nginx status with `sudo systemctl status nginx`.

## Contributing
Contributions are welcome! Feel free to submit pull requests or open issues for improvements.

---
### Created by [Jai Deep](https://github.com/jaideepp247) 🚀
