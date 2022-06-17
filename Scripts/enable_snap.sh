#! /bin/bash
# ./Scripts/enable_snap.sh


# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Installing Snap Store"
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
sudo snap refresh
notify-send "Snap store enabled"
read -rp "Press any key to continue" 