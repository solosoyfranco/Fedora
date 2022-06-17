#! /bin/bash
# ./start.sh

# fedora-scripts
# This is free software, and you are welcome to redistribute it
# under certain conditions
#
# Licensed under GPLv3 License

sudo dnf install git -y
git clone https://github.com/solosoyfranco/Fedora/
cd ./Fedora
sudo chmod a+x ./run_scripts.sh
source run_scripts.sh
