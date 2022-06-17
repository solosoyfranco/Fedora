#! /bin/bash
# ./Scripts/recover_button.sh

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Recovering maximize, minimize button"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
notify-send "Recovered maximiaze, minimize button"
read -rp "Press any key to continue"