#!/bin/bash
sudo apt-get update 2>&1 | dialog --title "Updating package database..." --infobox "\nPlease wait...\n" 11 70
dialog --title "Installing X11 and LXDE-core" --infobox "\nThise will take some time so please wait...\n" 11 70
sudo apt-get -y install lxde-core xserver-xorg xinit fbi
dialog --title "Download and install" --infobox "\nDownloading chromium and installing\n"  11 70
wget -q http://ftp.us.debian.org/debian/pool/main/libg/libgcrypt11/libgcrypt11_1.5.0-5+deb7u4_armhf.deb
wget -q http://dl.bintray.com/kusti8/chromium-rpi/pool/main/c/chromium-codecs-ffmpeg-extra/chromium-codecs-ffmpeg-extra_51.0.2704.79-0ubuntu0.14.04.1.1121_armhf.deb
wget -q http://dl.bintray.com/kusti8/chromium-rpi/pool/main/c/chromium-browser/chromium-browser_51.0.2704.79-0ubuntu0.14.04.1.1121_armhf.deb
sudo dpkg -i libgcrypt11_1.5.0-5+deb7u4_armhf.deb 2>&1
sudo dpkg -i chromium-codecs-ffmpeg-extra_51.0.2704.79-0ubuntu0.14.04.1.1121_armhf.deb 2>&1
sudo dpkg -i chromium-browser_51.0.2704.79-0ubuntu0.14.04.1.1121_armhf.deb 2>&1
if [ $? -gt 0 ]; then
dialog --title "Installing dependencies..." --infobox "\nPlease wait...\n" 11 70
sudo apt-get -f --force-yes --yes install >/dev/null 2>&1
sudo dpkg -i chromium-browser_51.0.2704.79-0ubuntu0.14.04.1.1121_armhf.deb 2>&1
fi
dialog --title "Download and install" --infobox "\nDownloading launcher and installing\n"  11 70
wget -q https://github.com/zjoasan/x11-osmc/raw/master/install_x11.zip 2>&1
unzip -q -o install_x11.zip 2>&1
chmod +x /home/osmc/x11-start/x_init.sh 2>&1
chmod +x /home/osmc/x11-start/xstart.sh 2>&1
dialog --title "Post setup tweaks" --infobox "\nChangeing default background in X11 and updating Kodi addons \nto reflect X11 launcher"  11 70
sudo ln /usr/splash.png /etc/alternatives/desktop-background 2>&1
sudo chmod 777 /etc/alternatives/desktop-background 2>&1
xbmc-send -a "UpdateLocalAddons" >/dev/null
dialog --title "Installation finnished!" --msgbox "\nThank you for using my installer\n"  11 70
exit