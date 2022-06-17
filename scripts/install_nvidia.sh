#! /bin/bash
# ./Scripts/install_nvidia.sh


# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Installing Nvidia Drivers"
modinfo -F version nvidia
sudo dnf update -y # and reboot if you are not on the latest kernel
sudo dnf install -y akmod-nvidia # rhel/centos users can use kmod-nvidia instead
sudo dnf install -y xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support
sudo dnf install -y xorg-x11-drv-nvidia-cuda-libs
sudo dnf install -y vdpauinfo libva-vdpau-driver libva-utils
sudo dnf install -y vulkan
modinfo -F version nvidia
notify-send "Drivers installed"
read -rp "Press any key to continue"