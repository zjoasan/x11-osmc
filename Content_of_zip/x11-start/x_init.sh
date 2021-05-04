#!/bin/bash
sleep 2
sudo systemctl stop eventlircd
sleep 2
sudo fbi -T 7 -d /dev/fb0 --noverbose /home/osmc/.kodi/addons/plugin.program.x11-launcher/fanart.jpg &
sleep 3
sudo openvt -c 7 -s -f clear
sudo su osmc -c "startx"
sudo openvt -c 7 -s -f clear
sudo systemctl start eventlircd
sudo systemctl start mediacenter
exit
