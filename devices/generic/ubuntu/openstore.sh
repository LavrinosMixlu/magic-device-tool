adb start-server
clear
zenity --info --title "OSwitcher" --text "Please enable developer mode on the device" --width=300 --height=200
zenity --info --title "OSwitcher | Developer mode" --text "Please enable developer mode on the device. This is located in system-settings → About → Developer Mode" --width=300 --height=200
zenity --info --title "OSwitcher | Pairing" --text "Please confirm the pairing dialog on the device" --width=300 --height=200
sleep 1
zenity --question --text "Is your OnePlus One in fastboot mode now?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200
sleep 1
#echo $? returns 0 for Nope and 1 for Yeap
if [ "$?"==1]; then
  clear
  zenity --info --title "OSwitcher | Detecting device" --text "We are trying to detecte your device"
  sleep 1
  adb devices >~/.AttachedDevices
  sleep 1
fi
if grep 'device$\|fastboot$' ~/.AttachedDevices
then
  	zenity --info --title "OSwitcher | Detecting device" --text "Device detected !!!"
  	sleep 1
  	exit | phablet-shell
	clear
	exit | phablet-shell
	clear
	zenity --info --title "OSwitcher | Installation" --text "Installing OpenStore.."
	adb shell "
	cd Downloads && wget -c --quiet --show-progress --tries=10 https://open.uappexplorer.com/api/download/openstore.openstore-team/openstore.openstore-team_latest_armhf.click && pkcon install-local --allow-untrusted openstore.openstore-team_latest_armhf.click && rm openstore.openstore-team_latest_armhf.click && exit"
	sleep 1
  	zenity --info --title "OSwitcher | Info" --text "Done...Back to menu"
	sleep 3
	rm -f ~/.AttachedDevices
	sleep 2
	. ./launcher.sh



else

  	zenity --warning --title "Detecting device" --text "Device not found"
  	sleep 1
      	rm -f ~/.AttachedDevices
  	zenity --info --title "Info" --text "Back to menu"
    	sleep 1
    	. ./launcher.sh
fi
