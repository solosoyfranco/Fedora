#! /bin/bash
# ./Scripts/install_auto_cpu.sh


# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

echo "- Installing auto-cpufreq"
echo -e "Please select the \"i\" option to install when the installer prompts"
# You can see the official install guide here 
# https://github.com/AdnanHodzic/auto-cpufreq/#auto-cpufreq-installer
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
chmod +x ./auto-cpufreq/auto-cpufreq-installer
sudo ./auto-cpufreq/auto-cpufreq-installer
sudo auto-cpufreq --install
notify-send "Installed auto-cpufreq"
read -rp "Press any key to continue"