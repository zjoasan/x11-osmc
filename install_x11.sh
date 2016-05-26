#!/bin/bash
sudo apt-get update 2>&1 | dialog --title "Updating package database..." --infobox "\nPlease wait...\n" 11 70
dialog --title "Trying install x11" --infobox "\nPlease wait...\n" 11 70
sudo apt-get -q install lxde-core xserver-xorg xinit  2>&1 
if [ $? -gt 0 ]; then
apt-get -f -q --force-yes --yes install >/dev/null 2>&1
fi
sudo apt-get --show-progress -y install lxde-core xserver-xorg xinit  2>&1 | grep --line-buffered -oP "(\d+(\.\d+)?(?=%))" | dialog --title "Installing X11 and LXDE-core" --gauge "\nPlease wait...\n" 11 70
dialog --title "Download and install" --infobox "\nDownloading chromium and installing\n"  11 70
wget -q http://ftp.us.debian.org/debian/pool/main/libg/libgcrypt11/libgcrypt11_1.5.0-5+deb7u4_armhf.deb
wget -q http://launchpadlibrarian.net/218525709/chromium-browser_45.0.2454.85-0ubuntu0.14.04.1.1097_armhf.deb
wget -q http://launchpadlibrarian.net/218525711/chromium-codecs-ffmpeg-extra_45.0.2454.85-0ubuntu0.14.04.1.1097_armhf.deb
sudo dpkg -i libgcrypt11_1.5.0-5+deb7u4_armhf.deb
sudo dpkg -i chromium-codecs-ffmpeg-extra_45.0.2454.85-0ubuntu0.14.04.1.1097_armhf.deb
sudo dpkg -i chromium-browser_45.0.2454.85-0ubuntu0.14.04.1.1097_armhf.deb
if [ $? -gt 0 ]; then
apt-get -f --force-yes --yes install >/dev/null 2>&1
fi
sudo dpkg -i chromium-browser_45.0.2454.85-0ubuntu0.14.04.1.1097_armhf.deb
dialog --title "Download and install" --infobox "\nDownloading launcher and installing\n"  11 70
wget -q https://github.com/zjoasan/x11-osmc/raw/master/install_x11.zip
unzip -q -o install_x11.zip
chmod +x /home/osmc/x11-start/x_init.sh
chmod +x /home/osmc/x11-start/xstart.sh
dialog --title "Post setup tweaks" --infobox "\nChangeing default background in X11 and adding a few desktop shortcuts\nFinally updating Kodi addons to reflext X11 launcher"  11 70
sudo ln /usr/splash.png /etc/alternatives/desktop-background
sudo chmod 777 /etc/alternatives/desktop-background
xbmc-send -a "UpdateLocalAddons" >/dev/null
dialog --title "Installation finnished!" --msgbox "\nThank you for using my installer\n"  11 70
exit

