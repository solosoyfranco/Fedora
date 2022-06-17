#! /bin/bash
# ./Scripts/install_dracula_theme.sh

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Installing Dracula theme"
sudo git clone https://github.com/dracula/gtk.git /usr/share/themes/Dracula
gsettings set org.gnome.desktop.interface gtk-theme 'Dracula' 
gsettings set org.gnome.desktop.wm.preferences theme 'Dracula'
notify-send "Installed Dracula theme"
read -rp "Press any key to continue" _