clear
zenity --info --title "OSwitcher" --text "Back Up/Restore your Android device" --width=300 --height=200
sleep 1
opt1="Back Up"
opt2="Restore"

opt3="Quit"
sleep 1

int6=`zenity --height=275 --list --radiolist --title "Lock bootloader" --text 'Please boot your Oneplus One into bootloader/fastboot mode by pressing Power AND Volume Up (+)' --column 'Select...' --column 'Options' TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" --width=610 --height=300`


if   [ "$int6" == 'Back Up' ]; then
  clear
  zenity --info --title "OSwitcher | Back up device" --text "Before connecting your Android device to your computer, make sure you enable USB Debugging"
  sleep 1
  zenity --question --text "Is your device in USB Debugging mode now?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200
  sleep 1
  if [ "$?"==1]; then
  	clear
	zenity --info --title "OSwitcher | Detecting device" --text "We are trying to detecte your device"
	sleep 1
  	adb devices >~/.AttachedDevices
  fi
    if grep 'device$\|fastboot$' ~/.AttachedDevices
    then
      zenity --info --title "OSwitcher | Detecting device" --text "Device detected !!!"
      sleep 1
      clear
      zenity --info --title "OSwitcher | Progress" --text "Back up process starts..."
      zenity --info --title "OSwitcher | Info" --text "A backup notification will appear on your device"
      zenity --info --title "OSwitcher | Device" --text "Tap Back up my data to confirm. It's recommended that you add a password to your backup file. The operation may take a long time depending on the size of your data to be backed up."
      adb backup -all -f backup.ab
      zenity --info --title "OSwitcher | Progress" --text "Cleaning up.."
      rm -f ~/.AttachedDevices
      zenity --info --title "OSwitcher | Info" --text "Exiting script. Bye Bye"
    else
      zenity --warning --title "OSwitcher | Progress" --text "Device not found"
      rm -f ~/.AttachedDevices
      sleep 1
      zenity --info --title "OSwitcher | Info" --text "Back to menu"
      sleep 1
      . ./launcher.sh
    fi
elif [ "$int6" == 'Restore' ]; then
  	clear
    echo ""
    zenity --info --title "OSwitcher | Restore device" --text "Restore your Android device using the backup file that you have created"
    zenity --warning --title "OSwitcher | Restore device" --text "Before connecting your Android device to your computer, make sure you enable USB Debugging"
    sleep 1
    zenity --question --text "Is your device in USB Debugging mode now?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200
    sleep 1
    if [ "$?"==1]; then
  	clear
	zenity --info --title "OSwitcher | Detecting device" --text "We are trying to detecte your device"
	sleep 1
  	adb devices >~/.AttachedDevices
    fi
      if grep 'device$\|fastboot$' ~/.AttachedDevices
      then
      zenity --info --title "OSwitcher | Detecting device" --text "Device detected !!!"
        sleep 1
        clear
  	adb restore backup.ab
        zenity --info --title "OSwitcher | Pregress" --text "Cleaning up.."
    	rm -f ~/.AttachedDevices
        sleep 1
        zenity --info --title "OSwitcher | Divice Restored" --text "Exiting script. Bye Bye"
        sleep 1
      else	
        zenity --info --title "OSwitcher | Info" --text "Device not found"
    	rm -f ~/.AttachedDevices
        sleep 1
        zenity --info --title "OSwitcher | Info" --text "Back to menu"
    	sleep 1
    	. ./launcher.sh
      fi
elif [ "$int6" == 'Quit' ]; then
        zenity --info --title "OSwitcher | Info" --text "Quit"
else
	zenity --warning --title "OSwitcher | Warning" --text "Device not found" --width=300 --height=200
        zenity --info --title "OSwitcher | Info" --text "Back to menu"
  	. ./launcher.sh
fi
