#! /bin/bash
# ./Scripts/enable_auto_updates.sh


# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- DNF flags to speed it up"
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

echo "- Enabling automatic updates"
sudo dnf install dnf-automatic -y
sudo cp dotfiles/dnf/automatic.conf /etc/dnf/automatic.conf
sudo systemctl enable --now dnf-automatic.timer
notify-send "Enabled dnf-automatic"
read -rp "Press any key to continue" 
