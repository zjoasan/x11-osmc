#!/bin/bash
fjupp="/home/osmc/.config/openbox/lxde-rc.xml"

if grep -q CONROLE "$fjupp"; then
	zenity --question  --text "Do you want to keep Virtual-mouse enabled?"
	if [[ $? = 0 ]]; then
		#echo "Yes keep it enabled"
		exit
	else
		#echo "Disable VMKB"
		sed '/Controlando/,/CONROLE/d' /home/osmc/.config/openbox/lxde-rc.xml > /home/osmc/.config/openbox/lxde-rc.xml.tmp ; mv /home/osmc/.config/openbox/lxde-rc.xml /home/osmc/.config/openbox/lxde-rc.xml.bak ; mv /home/osmc/.config/openbox/lxde-rc.xml.tmp /home/osmc/.config/openbox/lxde-rc.xml
		openbox --restart
		exit
	fi
else
	zenity --question  --text "Do you want enable Virtual-mouse?"
	if [[ $? = 0 ]]; then
		#echo "Enabled yes"
		f1="$(</home/osmc/x11-start/mouse.txt)"
	     	awk -vf1="$f1" '/\<\/keyboard\>/{print f1;print;next}1' /home/osmc/.config/openbox/lxde-rc.xml > /home/osmc/.config/openbox/lxde-rc.xml.tmp ; mv /home/osmc/.config/openbox/lxde-rc.xml /home/osmc/.config/openbox/lxde-rc.xml.bak ; mv /home/osmc/.config/openbox/lxde-rc.xml.tmp /home/osmc/.config/openbox/lxde-rc.xml
                openbox --restart
                exit
	else
		#echo "Dont enable"
		exit
	fi
fi
exit


