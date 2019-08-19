#!/bin/bash
       if [ "$(id -u)" != "1000" ]; then
                echo
                echo "This script must be run as osmc user." 1>&2
                echo
                exit 1
        fi


sudo apt-get update 2>&1 | dialog --title "Updating package database..." --infobox "\nPlease wait...\n" 11 70

dialog --title "Installing X11, LXDE-core and Chromium" --infobox "\nThise will take some time so please wait...\n" 11 70

sudo apt-get -y install lxde-core xserver-xorg xinit fbi libinput-dev xwit xdotool x11-utills xvkbd
wget http://launchpadlibrarian.net/380369885/chromium-codecs-ffmpeg-extra_68.0.3440.75-0ubuntu0.16.04.1_armhf.deb
wget http://launchpadlibrarian.net/380369879/chromium-browser_68.0.3440.75-0ubuntu0.16.04.1_armhf.deb
sudo dpkg -i chromium-codecs-ffmpeg-extra_68.0.3440.75-0ubuntu0.16.04.1_armhf.deb
sudo dpkg -i chromium-browser_68.0.3440.75-0ubuntu0.16.04.1_armhf.deb
sudo apt --fix-broken install
sudo dpkg -i chromium-browser_68.0.3440.75-0ubuntu0.16.04.1_armhf.deb
if [ $? -gt 0 ]; then
dialog --title "Installing dependencies..." --infobox "\nPlease wait...\n" 11 70
sudo apt-get -f --force-yes --yes install >/dev/null 2>&1
fi
dialog --title "Download and install" --infobox "\nDownloading launcher and installing\n" 11 70

wget -q https://github.com/zjoasan/x11-osmc/raw/master/install_x11.zip 2>&1
unzip -q -o install_x11.zip 2>&1
chmod +x /home/osmc/x11-start/x_init.sh 2>&1
chmod +x /home/osmc/x11-start/xstart.sh 2>&1
chmod +x /home/osmc/x11-start/virtualkeyboard-toogle.sh 2>&1
dialog --title "Post setup tweaks" --infobox "\nChangeing default background in X11 and updating Kodi addons \nto reflect X11 launcher" 11 70
sudo rm /usr/share/applications/kodi.desktop
sudo rm /usr/share/xsessions/kodi.desktop

sudo ln /usr/splash.png /etc/alternatives/desktop-background 2>&1
sudo chmod 777 /etc/alternatives/desktop-background 2>&1
xbmc-send -a "UpdateLocalAddons"

dialog --title "Installation finnished!" --msgbox "\nThank you for using my installer\n" 11 70
sudo systemctl disable lightdm
exit

