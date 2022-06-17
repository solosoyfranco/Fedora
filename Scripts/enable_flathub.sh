#! /bin/bash
# ./Scripts/enable_flathub.sh


# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Enabling Flathub"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
notify-send "Enabled Flathub"
read -rp "Press any key to continue"