# Fedora Workstation - Post Install script
Welcome to my personal Fedora installation script. In this particular document, I try to install most of the software I do use after a clean install of this awesome Linux distribution. Ideas and suggestions were collected from different sources and also from personal experience. 



## How to install:
Copy and paste this commands to your terminal:

  1. clone the script
  ```bash 
      git clone https://github.com/solosoyfranco/Fedora.git && cd ./Fedora
  ```
  2. make it executable & run it
  ```bash 
      chmod +x ./install.sh
      ./install.sh
  ```


## Screenshots

![install.sh](https://github.com/solosoyfranco/Fedora/blob/main/screenshot1.png?raw=true "install.sh")

![d3100](https://github.com/solosoyfranco/Fedora/blob/main/screenshot2.png?raw=true "Dell DisplayLink D3100 - 2x 25' dell 2k screens")


 


## Apps (Option 10)

* neofetch
* cmatrix
* htop
* p7zip
* gparted
* Visual Studio Code
* Notion app enhanced
* VLC
* dnfdragora
* google chrome
* microsoft edge
* brave browser
* discord
* remmina
* pomodoro timer
* Microsoft Teams
* Spotify
* GIMP
* GNOME Network Display
* Evolution email
* Agenda To-do list
* Dialect
* Inkscape
* Whatsapp
* Filezilla
* Parsec
* qBittorrent
* Thunderbird
* Dolphin file
* Disk Usage Analyzer
* Atom
* PyCharm Pro
* SQL client
* Prusa Slicer
* Ultimaker Cura
* Firmware
* QR Decoder
* Bluetooth Manager



### Recommended tabs & Sources
* https://extensions.gnome.org/extension/307/dash-to-dock/  (Fedora 35)
* https://extensions.gnome.org/extension/5004/dash-to-dock-for-cosmic/ (Fedora 36)
* https://extensions.gnome.org/extension/19/user-themes/
* https://extensions.gnome.org/extension/779/clipboard-indicator/
* https://extensions.gnome.org/extension/1262/bing-wallpaper-changer/
* https://extensions.gnome.org/extension/906/sound-output-device-chooser/
* https://extensions.gnome.org/extension/1401/bluetooth-quick-connect/
* https://extensions.gnome.org/extension/4245/gesture-improvements/
* https://extensions.gnome.org/extension/517/caffeine/
* https://extensions.gnome.org/extension/4099/no-overview/
* https://extensions.gnome.org/extension/3780/ddterm/
* https://extensions.gnome.org/extension/2741/remove-alttab-delay-v2/
* https://extensions.gnome.org/extension/4679/burn-my-windows/


### Notes
If your bluetooth doesn't connect with your headphones
```bash 
sudo nano /etc/bluetooth/main.conf 
```

locate and activate the following line

```bash
ControllerMode = dual
```
