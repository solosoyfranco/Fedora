#! /bin/bash
# ./start.sh
# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
# Licensed under GPLv3 License

HEIGHT=25
WIDTH=100
CHOICE_HEIGHT=4
BACKTITLE="Fedora post-install script by solosoyfranco (Franco Lopez)"
MENU_MSG="Please select one of following options:"

# First make a backup and optimize the dnf package manager
sudo cp /etc/dnf/dnf.conf /etc/dnf/dnf.conf.bak

# Check for updates
sudo dnf upgrade --refresh
sudo dnf autoremove -y
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update -y

# Install some tools required by the script
sudo dnf install axel deltarpm unzip -y

# Check if we have dialog installed
# If not, install it
if [ "$(rpm -q dialog 2>/dev/null | grep -c "is not installed")" -eq 1 ]; 
then
    sudo dnf install -y dialog
fi

OPTIONS=(
    1   "Enable automatic updates"
    2   "Enable RPM Fusion"
    3   "Enable Flathub"
    4   "Enable Snap"
    5   "Optimize booting time" 
    6   "Install Nvidia Drivers"
    7   "Install auto-cpufreq (recommended for laptop users)"
    8   "Install media codecs"
    9   "Install Google & Microsoft fonts"
    10  "Install Pop Shell for tiling window on GNOME"
    11  "Install Dracula theme"
    12  "Install tools (vsc, tweaks, etc)"
    13  "Install Fish with Tide (requires Powerline-compatible fonts)"
    14  "Install my daily apps"
    15  "Recover maximize, minimize button"
    16  "Secure your Linux system (by Chris Titus Tech)"
    17  "Reboot"
    18  "Quit"
)

while true; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE - Main menu $(lscpu | grep -i "Model name:" | cut -d':' -f2- - )" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU_MSG" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear
    case $CHOICE in 
        1) 
            scripts/enable_auto_updates.sh
        ;;
        2) 
            /scripts/enable_rpm_fusion.sh
        ;;
        3)
            ./scripts/enable_flathub.sh
        ;;
        4) 
            scripts/enable_snap.sh
        ;;
        5) 
            scripts/optimize_boot.sh
        ;;
        6) 
            scripts/install_nvidia.sh
        ;;
        7) 
            scripts/install_auto_cpu.sh
        ;;
        8) 
            scripts/install_media_codecs.sh
        ;;
        9)
            scripts/install_fonts.sh
        ;;
        10)
            scripts/install_pop_shell.sh
        ;;
        11)
            scripts/install_dracula_theme.sh
        ;;
        12)
            scripts/install_tools.sh
        ;;
        13)
            scripts/install_fish_tide.sh
        ;;
        14) 
            scripts/install_apps.sh
        ;;
        15) 
            scripts/recover_button.sh
        ;;
        16) 
            scripts/secure_linux.sh
        ;;
        17)
            sudo systemctl reboot
        ;;
        18) rm -rf CascadiaCode*
            exit 0
        ;;
    esac
done
