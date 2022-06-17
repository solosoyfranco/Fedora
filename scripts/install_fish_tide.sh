#! /bin/bash
# ./Scripts/install_fish_tide.sh

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License


echo "- Installing Fish"
        sudo dnf install fish -y

notify-send "Installed Fish, Fisher and Tide"
        read -rp "Press any key to continue" 