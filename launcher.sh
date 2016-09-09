#!/bin/bash
clear
#zenity --info --title "OSwitcher" --text "Checking for newer version" --width=300 --height=200
sleep 1

if [ $(dpkg-query -W -f='${Status}' phablet-tools 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  zenity --info --title "Necessary tools" --text "First we have to install the necessary tools: → phablet-tools" --width=300 --height=200
  sudo add-apt-repository -y ppa:ubuntu-sdk-team/ppa
  sudo apt-get -qq update
  sudo apt-get -qq -y install phablet-tools;
fi

if [ $(dpkg-query -W -f='${Status}' ubuntu-device-flash 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  zenity --info --title "Necessary tools" --text "First we have to install the necessary tools: → ubuntu-device-flash" --width=300 --height=200
  sudo add-apt-repository -y ppa:ubuntu-sdk-team/ppa
  sudo apt-get -qq update
  sudo apt-get -qq -y install ubuntu-device-flash;
fi

if [ $(dpkg-query -W -f='${Status}' android-tools-fastboot 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  zenity --info --title "Necessary tools" --text "First we have to install the necessary tools: → android-tools-fastboot" --width=300 --height=200
  sudo apt-get -qq -y install android-tools-fastboot;
fi

if [ $(dpkg-query -W -f='${Status}' android-tools-adb 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  zenity --info --title "Necessary tools" --text "First we have to install the necessary tools: → android-tools-adb" --width=300 --height=200
  echo "First we have to install the necessary tools:"
  sudo apt-get install -qq -y android-tools-adb;
fi

if [ $(dpkg-query -W -f='${Status}' mplayer 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  zenity --info --title "Necessary tools" --text "First we have to install the necessary tools: → mplayer" --width=300 --height=200
  sudo apt-get install -qq -y mplayer;
fi

clear
sleep 1

opt21="OnePlus"
opt22="Exit"

int4=`zenity --height=275 --list --radiolist --title "Devices" --text 'Choose your device:' --column 'Select...' --column 'Options' TRUE "$opt21" FALSE "$opt22" --width=610 --height=300`

if   [ "$int4" == 'OnePlus' ]; then
	echo $int4
	. ./devices/oneplusone/oneplusone.sh
elif [ "$int4" == 'Back to menu' ]; then
	exit
else
	zenity --warning --title "Invalid Option" --text "You did not choose any of the supported devices" --width=300 --height=200
fi
