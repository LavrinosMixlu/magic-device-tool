#!/bin/bash
chmod +x . ./devices/oneplusone/ubuntu/*.sh
chmod +x . ./devices/oneplusone/android/*.sh
chmod +x . ./devices/generic/ubuntu/*.sh
chmod +x . ./devices/generic/android/*.sh
clear
zenity --info --title "OSwitcher" --text "OnePlus One - bacon" --width=300 --height=200
sleep 1
opt1="Install Ubuntu"
opt2="Install OpenStore"

opt3="Install Cyanogenmod 13"
opt4="Install Cyanogenmod 13 without Gapps"
opt5="Install TWRP recovery"
opt6="Back Up your Android device"
opt7="Lock/Unlock bootloader (Will wipe existing apps/data)"

opt8="Back to menu"

opt9="Ubuntu"
opt10="Android"

int=`zenity --height=275 --list --radiolist --title "OSwitcher | OnePlus One - bacon" --text 'Select the OS to be installed:' --column 'Select...' --column 'Options' --column 'OS' TRUE "$opt1" "$opt9" FALSE "$opt2" "$opt9" FALSE "$opt3" "$opt10" FALSE "$opt4" "$opt10" FALSE "$opt5" "$opt10" FALSE "$opt6" "$opt10" FALSE "$opt7" "$opt10" FALSE "$opt8" " " --width=610 --height=300`


if   [ "$int" == 'Install Ubuntu' ]; then
	. ./devices/oneplusone/ubuntu/ubuntu.sh
elif [ "$int" == 'Install OpenStore' ]; then
  	. ./devices/generic/ubuntu/openstore.sh
elif [ "$int" == 'Install Cyanogenmod 13' ]; then
  	. ./devices/oneplusone/android/cyanogenmod.sh
elif [ "$int" == 'Install Cyanogenmod 13 without Gapps' ]; then
  	. ./devices/oneplusone/android/cyanogenmodwogapps.sh
elif [ "$int" == 'Install TWRP recovery' ]; then
  	. ./devices/oneplusone/android/twrp.sh
elif [ "$int" == 'Back Up your Android device' ]; then
  	. ./devices/generic/android/backup.sh
elif [ "$int" == 'Lock/Unlock bootloader (Will wipe existing apps/data)' ]; then
  	. ./devices/oneplusone/android/bootloader.sh
elif [ "$int" == 'Back to menu' ]; then
  	. ./launcher.sh
else
	zenity --warning --title "OSwitcher | Invalid Option" --text "Something went wrong try again" --width=300 --height=200  	
  	exit
fi
