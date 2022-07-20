----update system---
sudo dnf -y upgrade --refresh

---update firmware---
sudo fwupdmgr get-devices
sudo fwupdmgr refresh --force
sudo fwupdmgr get-updates
sudo fwupdmgr update -y
sudo dnf makecache

-----enable RPM fusion----
sudo dnf makecache
sudo dnf update
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf upgrade --refresh
sudo dnf groupupdate core
sudo dnf install -y rpmfusion-free-release-tainted
sudo dnf install -y rpmfusion-nonfree-release-tainted 
sudo dnf install -y dnf-plugins-core
sudo dnf install -y *-firmware

---nvidia-----
1. Depending on your GPU model, use the appropriate command to install corresponding Nvidia drivers. For current GeForce/Quadro/Tesla models, use:
sudo dnf install akmod-nvidia
For legacy drivers for GeForce 400/500 models, use:
sudo dnf install xorg-x11-drv-nvidia-390xx akmod-nvidia-390xx
For legacy drivers for GeForce 8/9/200/300 models, use:
sudo dnf install xorg-x11-drv-nvidia-340xx akmod-nvidia-340xx
When prompted, type Y and press Enter to confirm the installation.
	---manual way ---
	source:https://phoenixnap.com/kb/fedora-nvidia-drivers
	https://www.nvidia.com/Download/index.aspx
	chmod +X NVIDIA-Linux-x86_64-515.48.07.run 
	sudo dnf update
	sudo dnf install kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
	sudo nano /etc/modprobe.d/blacklist.conf
		blacklist nouveau
		options nouveau modeset=0
	sudo nano /etc/default/grub
		## Example row with Fedora 36 BTRFS NVIDIA 515xx, 510xx + Wayland enabled ##
		GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau nvidia-drm.modeset=1"
	sudo grub2-mkconfig -o /boot/grub2/grub.cfg
	sudo dnf remove xorg-x11-drv-nouveau
	sudo dracut --force /boot/initramfs-$(uname -r).img $(uname -r)
	systemctl set-default multi-user.target
	sudo reboot
	sudo bash NVIDIA-Linux-x86_64-515.48.07.run 
	systemctl set-default graphical.target
	sudo reboot
	--- uninstall nvidia bc of error
	sudo nvidia-installer --uninstall
	
------hostname -----
hostnamectl set-hostname X12

------speed DNF ----- 
echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf

---gnome tweaks --- 
sudo dnf install gnome-tweak-tool gnome-tweaks gnome-extensions-app
### https://github.com/brunelli/gnome-shell-extension-installer #extension installer source
#required apps by installer
sudo dnf install curl dbus perl git less
	wget -O gnome-shell-extension-installer "https://github.com/brunelli/gnome-shell-extension-installer/raw/master/gnome-shell-extension-installer"
	chmod +x gnome-shell-extension-installer
	sudo mv gnome-shell-extension-installer /usr/bin/
	
---gnome Extensions --- 
gnome-shell-extension-installer 19 --yes #user-themes
gnome-shell-extension-installer 779 --yes #clipboard indicator
gnome-shell-extension-installer 1262 --yes #bing wallpaper
gnome-shell-extension-installer 517 --yes #caffeine
gnome-shell-extension-installer 906 --yes #sound output device chooser
gnome-shell-extension-installer 3780 --yes #ddterm
gnome-shell-extension-installer 1460 --yes #vitals
gnome-shell-extension-installer 3843 --yes #just perfection
gnome-shell-extension-installer 570 --yes #TODO list

--enable extensions---
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable clipboard-indicator@tudmotu.com 
gnome-extensions enable BingWallpaper@ineffable-gmail.com
gnome-extensions enable caffeine@patapon.info
gnome-extensions enable sound-output-device-chooser@kgshank.net
gnome-extensions enable ddterm@amezin.github.com
gnome-extensions enable Vitals@CoreCoding.com
gnome-extensions enable just-perfection-desktop@just-perfection
gnome-extensions enable todo.txt@bart.libert.gmail.com






---flatpak -----
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    ---extensions flatpak
	flatpak install flathub org.gnome.Extensions
	sudo dnf install chrome-gnome-shell
flatpak update

---snap store----
sudo dnf install -y snapd
sudo ln -s /var/lib/snapd/snap /snap # for classic snap support



---- fonts ----
sudo dnf install -y 'google-roboto*' 'mozilla-fira*' fira-code-fonts

---fedy----
sudo dnf copr enable kwizart/fedy
sudo dnf install fedy -y

----dnf apps---
sudo dnf install -y vlc steam transmission gimp geary unzip p7zip p7zip-plugins unrar gparted 

---multimedia plugins ----
sudo dnf groupupdate -y sound-and-video
sudo dnf install -y libdvdcss libdrm-devel gtk3-devel gcc pkg-config
sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,ugly-\*,base} gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel 
ffmpeg gstreamer-ffmpeg
sudo dnf install lame\* --exclude=lame-devel
sudo dnf group upgrade -y --with-optional Multimedia

----loading boot ---- systemd-analyze blame
sudo systemctl disable NetworkManager-wait-online.service #takes too much to load
sudo systemctl disable dnf-makecache #same here
sudo systemctl disable lvm2-monitor.service # i dont have my hdd encrypted

---- gsettings ----
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"





---flatpak apps ----
	#extension manager
flatpak install -y flathub com.mattjakeman.ExtensionManager
	#audacity
flatpak install -y flathub org.audacityteam.Audacity
	#spotify
flatpak install -y flathub com.spotify.Client
	#remmina
flatpak install -y flathub org.remmina.Remmina
	$discord
flatpak install -y flathub com.discordapp.Discord
	#Gimp
flatpak install -y flathub org.gimp.GIMP
	#network displays
flatpak install -y flathub org.gnome.NetworkDisplays
	#evolution email
flatpak install -y flathub org.gnome.Evolution
	#inkscape
flatpak install -y flathub org.inkscape.Inkscape
	#Whatsapp
flatpak install -y flathub com.rtosta.zapzap
	#Filezilla
flatpak install -y flathub org.filezillaproject.Filezilla
	#parsec
flatpak install -y flathub com.parsecgaming.parsec
	#qbittorrent
flatpak install -y flathub org.qbittorrent.qBittorrent
	# Disk analyzer
flatpak install -y flathub org.gnome.baobab
	# Atom
flatpak install -y flathub io.atom.Atom
	#Pycharm pro
flatpak install -y flathub com.jetbrains.PyCharm-Professional
	# SQL client 
flatpak install -y flathub com.github.alecaddd.sequeler
	# Firmware
flatpak install -y flathub org.gnome.Firmware
	# Decoder 
flatpak install -y flathub com.belmoussaoui.Decoder
	#ultimaker cura 
flatpak install -y flathub com.ultimaker.cura
	#retroarch
flatpak install -y flathub org.libretro.RetroArch
	#onlyoffice
flatpak install -y flathub org.onlyoffice.desktopeditors
	#anydesk
flatpak install -y flathub com.anydesk.Anydesk
	#multiscreen wallpaper manager
flatpak install -y flathub org.gabmus.hydrapaper
	#dialect
flatpak install -y flathub app.drey.Dialect


---repos & apps ---
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
#microsoft teams
sudo sh -c 'echo -e "[teams]\nname=teams\nbaseurl=https://packages.microsoft.com/yumrepos/ms-teams\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/teams.repo'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#Teamviewer
wget https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm && sudo dnf -y install ./teamviewer.x86_64.rpm

# install software
sudo dnf check-update
sudo dnf install -y vlc dnfdragora mscore-fonts-all google-noto-sans-fonts neofetch cmatrix p7zip unzip gparted google-chrome-stable clang cmake microsoft-edge-stable code htop brave-browser notion-app-enhanced gnome-pomodoro teams prusa-slicer blueman

---manually -- 
settings:
appearence -> dark
multitasking -> hot corner off
keyboard settings: 
	close -> CTRL+Q
	open home -> Super+E
Users -> picture
Date time -> hour format AM/PM
just perfection -> move clock, fast animations, desktop startup, padding space
ddterm -> open with CTRL+`


-----end------
sudo dnf update -y
sudo dnf autoremove -y


---- falto por instalar -----

----"Appearance Tweaks - Flat GTK and Icon Theme"
sudo dnf install -y gnome-shell-extension-user-theme paper-icon-theme flat-remix-icon-theme flat-remix-theme 
gnome-extensions install user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gsettings set org.gnome.desktop.interface gtk-theme "Flat-Remix-GTK-Blue"
gsettings set org.gnome.desktop.wm.preferences theme "Flat-Remix-Blue"
gsettings set org.gnome.desktop.interface icon-theme 'Flat-Remix-Blue'
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

-------"KVM virtualization software"
sudo dnf -y install bridge-utils libvirt virt-install qemu-kvm
sudo dnf -y install libvirt-devel virt-top libguestfs-tools guestfs-tools
sudo systemctl enable libvirtd
sudo dnf -y install virt-manager

