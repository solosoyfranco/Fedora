#! /bin/bash
# ./Scripts/install_media_codecs.sh
# SPDX-License-Identifier: GPL-3.0-or-later

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License


echo "- Installing media codecs"
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y
notify-send "Installed media codecs"
read -rp "Press any key to continue" 