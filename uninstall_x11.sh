#!/bin/bash
sudo apt-get update 2>&1 | dialog --title "Updating package database..." --infobox "\nPlease wait...\n" 11 70
dialog --title "Uninstalling X11, LXDE-core and Chromium" --infobox "\nThise will take some time so please wait...\n" 11 70
sudo apt-get -y --purge remove lxde-core xserver-xorg xinit fbi openbox gconf-service libgconf-2-4 libnspr4 libnspr4-0d libnss3 libnss3-1d libxss1 libnss3 xdg-utils xwit xdotool x11-utills xvkbd
sudo dpkg -r chromium-browser
sudo dpkg -r chromium-codecs-ffmpeg-extra
sudo apt-get -y --purge autoremove
rm -rf x11-start
rm -rf Desktop
rm -rf .config/lx*
rm -rf .config/chromium
rm -rf .config/openbox
rm -rf .config/pcmanfm
rm -rf .kodi/addons/plugin.program.x11-launcher
sudo rm -f /etc/alternatives/desktop-background
xbmc-send -a "UpdateLocalAddons" >/dev/null
dialog --title "Uninstallation finnished!" --msgbox "\nThank you for using my uninstaller\n"  11 70
exit

