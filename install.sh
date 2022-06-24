#!/bin/bash
# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
# Licensed under GPLv3 License
# sources
# https://github.com/davidhoang05022009/fedora-post-install-script
# https://github.com/osiris2600/fedora-setup

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
HEIGHT=20
WIDTH=90
CHOICE_HEIGHT=4
BACKTITLE="Fedora Workstation Post-Install - By Franco Lopez - https://github.com/solosoyfranco"
TITLE="Make a selection"
MENU="Please choose one of the following options:"
#hostnamectl set-hostname NEW
#Other variables
OH_MY_ZSH_URL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"

#Check to see if Dialog is installed, if not install it
if [ $(rpm -q dialog 2>/dev/null | grep -c "is not installed") -eq 1 ]; then
sudo dnf install -y dialog
fi

OPTIONS=(1  "Change Hostname"
         2  "Manually update system & firmware"
         3  "Enable RPM Fusion - Enables the RPM Fusion Repos"
         4  "Enable App Stores (Flatpak & Snap)"
         5  "Enable Tweaks, Media Codecs, Extensions & Plugins"
         6  "Install Nvidia Drivers"
         7  "Enable Better Fonts - Better font rendering"
         8  "Enable Flat Theme - Installs and Enables the Flat GTK and Icon themes"
         9  "Speed up DNF - This enables fastestmirror, max downloads and deltarpms"
         10 "Install Common Software - Installs a bunch of my most used software"
         11 "Install KVM virtualization software"
         12 "Install DisplayLink Dock (d3100)"
         13 "Install Oh-My-ZSH"
         14 "Reboot"
         15 "Quit")

while [ "$CHOICE -ne 4" ]; do
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --nocancel \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

    clear
    case $CHOICE in
        1)
            echo "Change hostname"
            ### pending
            notify-send "Option 1 - hostname changed" --expire-time=10
            ;;
        2)
            echo "Manually update system & firmware"
            sudo dnf update -y
            sudo dnf autoremove -y
            sudo fwupdmgr get-devices
            sudo fwupdmgr refresh --force
            sudo fwupdmgr get-updates
            sudo fwupdmgr update -y
            notify-send "Option 2 - System updated" --expire-time=10
            ;;
        3)  echo "Enabling RPM Fusion"
            sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	        sudo dnf upgrade --refresh
            sudo dnf groupupdate -y core
            sudo dnf install -y rpmfusion-free-release-tainted
            sudo dnf install -y dnf-plugins-core
            notify-send "Option 3 - RPM Fusion Enabled" --expire-time=10
            ;;
        4)  echo "Enabling Flatpak & Snap"
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak update
            sudo dnf install -y snapd
            sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
            sudo snap refresh
            notify-send "Option 4 - Flatpak & Snap has now been enabled" --expire-time=10
            ;;
        5)  echo "Installing Tweaks, media codecs, extensions & plugins"
            sudo dnf groupupdate -y sound-and-video
            sudo dnf install -y gnome-tweaks
            sudo dnf install -y libdvdcss libdrm-devel gtk3-devel gcc pkg-config
            sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel ffmpeg gstreamer-ffmpeg
            sudo dnf install -y lame\* --exclude=lame-devel
            sudo dnf group upgrade -y --with-optional Multimedia
            sudo systemctl disable NetworkManager-wait-online.service #takes too much to load
            sudo systemctl disable dnf-makecache #same here
            sudo systemctl disable lvm2-monitor.service # i dont have my hdd encrypted
            # to see your loading time apps
            # systemd-analyze blame  
            # Add VPN L2PT option --- not fully working with L2TP over ipsec
            # sudo dnf -y install xl2tpd
            # sudo dnf -y install NetworkManager-l2tp
            # sudo dnf -y install NetworkManager-l2tp-gnome
            # service NetworkManager restart
            notify-send "Option 5 - Tweaks and extras installed" --expire-time=10
            ;;
        6)
            echo "Nvidia drivers"
            modinfo -F version nvidia
            sudo dnf update -y # and reboot if you are not on the latest kernel
            sudo dnf install -y akmod-nvidia # rhel/centos users can use kmod-nvidia instead
            sudo dnf install -y xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support
            sudo dnf install -y xorg-x11-drv-nvidia-cuda-libs
            sudo dnf install -y vdpauinfo libva-vdpau-driver libva-utils
            sudo dnf install -y vulkan
            modinfo -F version nvidia
            notify-send "Option 6 - Nvidia Drivers" --expire-time=10
            ;;
        7)  echo "Enabling Better Fonts"
            sudo -s dnf -y copr enable dawid/better_fonts
            sudo -s dnf install -y fontconfig-font-replacements
            sudo -s dnf install -y fontconfig-enhanced-defaults
            notify-send "Option 7 - Fonts prettified - enjoy!" --expire-time=10
            ;;
        8)  echo "Appearance Tweaks - Flat GTK and Icon Theme"
            sudo dnf install -y gnome-shell-extension-user-theme paper-icon-theme flat-remix-icon-theme flat-remix-theme 
            gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com
            gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
            gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue"
            gsettings set org.gnome.desktop.wm.preferences theme "Flat-Remix-Blue"
            gsettings set org.gnome.desktop.interface icon-theme 'Flat-Remix-Blue'
            gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
            notify-send "Option 8 - There you go, that's better" --expire-time=10
            ;;
        9)  echo "Speeding Up DNF"
            echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
            echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
            notify-send "Option 9 - Your DNF config has now been amended" --expire-time=10
           ;;
        10)  echo "Installing Software"
            #notion repo
            echo '[notion-repackaged]' | sudo tee -a /etc/yum.repos.d/notion-repackaged.repo
            echo 'name=notion-repackaged' | sudo tee -a /etc/yum.repos.d/notion-repackaged.repo
            echo 'baseurl=https://yum.fury.io/notion-repackaged/' | sudo tee -a /etc/yum.repos.d/notion-repackaged.repo
            echo 'enabled=1' | sudo tee -a /etc/yum.repos.d/notion-repackaged.repo
            echo 'gpgcheck=0' | sudo tee -a /etc/yum.repos.d/notion-repackaged.repo
            #VSC repo
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            #microsoft edge repo
            sudo rpm -v --import https://packages.microsoft.com/keys/microsoft.asc
            sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
            sudo mv /etc/yum.repos.d/packages.microsoft.com_yumrepos_edge.repo /etc/yum.repos.d/microsoft-edge.repo
            #brave repo
            sudo dnf install -y dnf-plugins-core
            sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
            sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
            #install remmina
            sudo dnf copr enable hubbitus/remmina-next -y
            sudo dnf install -y remmina
            sudo dnf upgrade --refresh 'remmina*' 'freerdp*'
            #install discord
            flatpak install -y flathub com.discordapp.Discord
            ##better discord
            curl -O https://raw.githubusercontent.com/bb010g/betterdiscordctl/master/betterdiscordctl
            chmod +x betterdiscordctl
            sudo mv betterdiscordctl /usr/local/bin
            betterdiscordctl --d-install flatpak install
            betterdiscordctl self-upgrade
            #microsoft teams
            sudo sh -c 'echo -e "[teams]\nname=teams\nbaseurl=https://packages.microsoft.com/yumrepos/ms-teams\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/teams.repo'
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            #spotify 
            sudo flatpak install -y flathub com.spotify.Client
            #Gimp
            sudo flatpak install -y flathub org.gimp.GIMP
            #network displays
            sudo flatpak install -y flathub org.gnome.NetworkDisplays
            #evolution email
            sudo flatpak install -y flathub org.gnome.Evolution
            #agenda to do
            sudo flatpak install -y flathub com.github.dahenson.agenda
            #dialect
            sudo flatpak install -y flathub com.github.gi_lom.dialect
            #inkscape
            sudo flatpak install -y flathub org.inkscape.Inkscape
            #Whatsapp
            sudo flatpak install -y flathub com.rtosta.zapzap
            #Filezilla
            sudo flatpak install -y flathub org.filezillaproject.Filezilla
            #parsec
            sudo flatpak install -y flathub com.parsecgaming.parsec
            #qbittorrent
            sudo flatpak install -y flathub org.qbittorrent.qBittorrent
            #thunderbild mail
            sudo flatpak install -y flathub org.mozilla.Thunderbird
            #Dolphin file explorer
            sudo flatpak install -y flathub org.kde.dolphin
            # Disk analyzer
            sudo flatpak install -y flathub org.gnome.baobab
            # Atom
            sudo flatpak install -y flathub io.atom.Atom
            #Pycharm pro
            sudo flatpak install -y flathub com.jetbrains.PyCharm-Professional
            # SQL client 
            sudo flatpak install -y flathub com.github.alecaddd.sequeler
            #Teamviewer
            wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm && sudo dnf -y install ./teamviewer.x86_64.rpm
            # Firmware
            sudo flatpak install -y flathub org.gnome.Firmware
            # Decoder 
            sudo flatpak install -y flathub com.belmoussaoui.Decoder
            #ultimaker cura 
            sudo flatpak install -y flathub com.ultimaker.cura



            # install software
            sudo dnf check-update
            sudo dnf install -y gnome-extensions-app gnome-tweaks gnome-shell-extension-appindicator vlc dnfdragora mscore-fonts-all google-noto-sans-fonts neofetch cmatrix p7zip unzip gparted google-chrome-stable clang cmake microsoft-edge-stable code htop brave-browser notion-app-enhanced gnome-pomodoro teams prusa-slicer blueman
            notify-send "Option 10 - Software has been installed" --expire-time=10
            ;;
        11) echo "KVM virtualization software"
            sudo dnf -y install bridge-utils libvirt virt-install qemu-kvm
            sudo dnf -y install libvirt-devel virt-top libguestfs-tools guestfs-tools
            sudo systemctl enable libvirtd
            sudo dnf -y install virt-manager
            notify-send "Option 13 - KVM installed" --expire-time=10
            ;;
        12) echo "Install DisplayLink Dock (d3100)"
            sudo dnf install -y libdrm-devel
            ####source: https://github.com/displaylink-rpm/displaylink-rpm
            # git clone https://github.com/displaylink-rpm/displaylink-rpm.git && cd displaylink-rpm
            # make github-release
            # openssl req -new -x509 -newkey rsa:2048 -keyout MOK.priv -outform DER -out \
            # MOK.der -nodes -days 36500 -subj "/CN=Displaylink/"
            # sudo mokutil --import MOK.der
            #### the above steps is only when you have secure boot enabled, and only works on fedora 35
            #for fedora 36 you need the 1.11 driver that I add in the git
            sudo rpm -i Displaylink/displaylink-1.11.0-1.github_evdi.x86_64.rpm
            notify-send "Option 12 - install RPM from the folder x86" --expire-time=10
            ;;
        13)  echo "Installing Oh-My-Zsh"
            sudo dnf -y install zsh util-linux-user
            sh -c "$(curl -fsSL $OH_MY_ZSH_URL)"
            echo "change shell to ZSH"
            chsh -s "$(which zsh)"
            notify-send "Option 11 - Oh-My-Zsh is ready to rock n roll" --expire-time=10
           ;;
        
        14)
            sudo systemctl reboot
        ;;
        15)
          exit 0
          ;;
    esac
done