#! /bin/bash
# ./Scripts/recover_button.sh

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Recovering maximize, minimize button"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"

# gsettings set org.gnome.desktop.interface clock-show-seconds true
# gsettings set org.gnome.desktop.interface clock-show-date true

# gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false

# gsettings set org.gnome.software download-updates false

# gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
# gsettings set org.gnome.gedit.preferences.editor display-right-margin true
# gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
# gsettings set org.gnome.gedit.preferences.editor bracket-matching true
# gsettings set org.gnome.gedit.preferences.editor tabs-size 2
# gsettings set org.gnome.gedit.preferences.editor auto-indent true
# gsettings set org.gnome.gedit.preferences.editor insert-spaces true
# gsettings set com.gexperts.Tilix.Settings focus-follow-mouse true
# gsettings set com.gexperts.Tilix.Settings auto-hide-mouse true
# gsettings set com.gexperts.Tilix.Settings copy-on-select true
# gsettings set com.gexperts.Tilix.Settings terminal-title-show-when-single true
# gsettings set com.gexperts.Tilix.Settings terminal-title-style 'normal' #none
# gsettings set com.gexperts.Tilix.Settings window-style 'normal' #borderless

# gsettings set org.gnome.desktop.wm.preferences focus-mode 'mouse'
# gsettings set org.gnome.desktop.interface show-battery-percentage true

# gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
# gsettings set org.gnome.clocks world-clocks "[{'location': <(uint32 2, <('Salt Lake City', 'KSLC', true, [(0.71171133976262879, -1.9542354594274096)], [(0.71140979922776182, -1.9528671736537238)])>)>}, {'location': <(uint32 2, <('New York', 'KNYC', true, [(0.71180344078725644, -1.2909618758762367)], [(0.71059804659265924, -1.2916478949920254)])>)>}, {'location': <(uint32 2, <('Istanbul', 'LTBA', true, [(0.71500322271810779, 0.50294571860079684)], [(0.71590981654476371, 0.505529765824837)])>)>}]"

# gsettings set org.gnome.shell favorite-apps "['firefox.desktop', 'google-chrome.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Nautilus.desktop', 'code.desktop', 'com.gexperts.Tilix.desktop']"

# # Enable the 
# gnome-shell-extension-tool -e pomodoro@arun.codito.in
# gnome-shell-extension-tool -e suspend-button@laserb
# gnome-shell-extension-tool -e TopIcons@phocean.net
# gnome-shell-extension-tool -e calc@patapon.info
# gnome-shell-extension-tool -e GPaste@gnome-shell-extensions.gnome.org



notify-send "Recovered maximiaze, minimize button"
read -rp "Press any key to continue"