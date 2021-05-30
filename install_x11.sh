#!/bin/bash
# check user before install
if [ "$(id -u)" != "1000" ]; then
	echo
	echo "This script must be run as osmc user." 1>&2
	echo
	exit 1
fi

#Set UTF-8; e.g. "en_US.UTF-8" or "de_DE.UTF-8":
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
sudo locale-gen en_US.UTF-8 &> /dev/null

#Tell ncurses to use line characters that work with UTF-8.
export NCURSES_NO_UTF8_ACS=1

sudo apt-get update 2>&1 | dialog --title "Updating package database..." --infobox "\nPlease wait...\n" 11 70

dialog --title "Installing X11, LXDE-core and Chromium" --infobox "\nThise will take some time so please wait...\n" 11 70

export DEBIAN_FRONTEND=noninteractive
sudo apt-get -y install lxde-core xserver-xorg xinit fbi libinput-dev xwit xdotool x11-utils xvkbd zenity xterm
butrue=$(lsb_release -d | grep -v grep | grep -c "buster")
if [ $butrue -ne 0 ]; then
       sudo apt-get install chromium-common chromium chromium-sandbox
else
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
fi
dialog --title "Download and install" --infobox "\nDownloading launcher and installing\n" 11 70

wget -q https://github.com/zjoasan/x11-osmc/raw/Leia/install_x11.zip 2>&1
unzip -q -o install_x11.zip 2>&1
chmod +x /home/osmc/x11-start/x_init.sh 2>&1
chmod +x /home/osmc/x11-start/xstart.sh 2>&1
chmod +x /home/osmc/x11-start/virtualkeyboard-toogle.sh 2>&1
chmod +x /home/osmc/x11-start/vmkd-switcher.sh  2>&1
dialog --title "Post setup tweaks" --infobox "\nChangeing default background in X11 and updating Kodi addons \nto reflect X11 launcher" 11 70
sudo rm /usr/share/applications/kodi.desktop
sudo rm /usr/share/xsessions/kodi.desktop

sudo ln /usr/splash.png /etc/alternatives/desktop-background 2>&1
sudo chmod 777 /etc/alternatives/desktop-background 2>&1

mctrue=$(pgrep -c "mediacenter")
if [ $mctrue -ne 0 ]; then
        xbmc-send -a "UpdateLocalAddons"
	sleep 4
	sudo systemctl stop mediacenter
	sleep 4
	sqlite3 /home/osmc/.kodi/userdata/Database/Addons27.db "UPDATE installed SET enabled = 1 WHERE addonID = 'plugin.program.x11-launcher'"
	sleep 4
	sudo systemctl start mediacenter
fi

dialog --title "Installation finished!" --msgbox "\nThank you for using my installer\n" 11 70

lidmtrue=$(dpkg -s lightdm | grep -c "Status: install ok installed")
if [ $lidmtrue -ne 0 ]; then
       sudo systemctl stop lightdm
       sudo systemctl disable lightdm
fi

exit

