#! /bin/bash
# ./Scripts/secure_linux.sh

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License


echo "- Enhancing your Linux system's security"
sudo dnf install ufw fail2ban -y
sudo systemctl enable --now ufw.service
sudo systemctl disable --now firewalld.service
git clone https://github.com/ChrisTitusTech/secure-linux
chmod +x ./secure-linux/secure.sh
sudo ./secure-linux/secure.sh
notify-send "Enhanced your Linux system's security"
read -rp "Press any key to continue" 