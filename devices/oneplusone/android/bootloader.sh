clear
zenity --info --title "OSwitcher" --text "Lock/Unlock bootloader (Will wipe existing apps/data)" --width=300 --height=200
sleep 1
opt1="Lock bootloader"
opt2="Unlock bootloader"

opt3="Quit"
sleep 1

int5=`zenity --height=275 --list --radiolist --title "OSwitcher | Lock bootloader" --text 'Please boot your Oneplus One into bootloader/fastboot mode by pressing Power AND Volume Up (+)' --column 'Select...' --column 'Options' FALSE "$opt1" TRUE "$opt2" FALSE "$opt3" --width=610 --height=300`


if   [ "$int5" == 'Lock bootloader' ]; then
  clear
  zenity --info --title "OSwitcher | Lock/Unlock bootloader" --text "Lock bootloader"
  zenity --info --title "OSwitcher | Boot into fastboot mode" --text "Please boot your Oneplus One into bootloader/fastboot mode by pressing Power AND Volume Up (+)" --width=300 --height=200
  sleep 1
  zenity --question --text "Is your Oneplus One in bootloader/fastboot mode now ?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200
  sleep 1
  if [ "$?"==1]; then
  	clear
	zenity --info --title "OSwitcher | Detecting device" --text "We are trying to detecte your device"
	sleep 1
	fastboot devices >~/.AttachedDevices    
  fi
    if grep 'device$\|fastboot$' ~/.AttachedDevices
    then
      zenity --info --title "OSwitcher | Detecting device" --text "Device detected !!!"
      sleep 1
      clear
      fastboot oem lock
      sleep 1
      zenity --info --title "OSwitcher | Bootloader locked" --text "Device detected !!!"
      zenity --info --title "OSwitcher | Info" --text "Cleaning up.."
      rm -f ~/.AttachedDevices
      zenity --info --title "OSwitcher | Bootloader locked" --text "Your Bootloader is locked"
      sleep 1
      exit
    fi
elif [ "$int5" == 'OSwitcher |Unlock bootloader' ]; then
  	clear
    zenity --info --title "OSwitcher | Lock/Unlock bootloader" --text "Unlock bootloader"
    zenity --info --title "OSwitcher | Boot into fastboot mode" --text "Please boot your Oneplus One into bootloader/fastboot mode by pressing Power AND Volume Up (+)" --width=300 --height=200
    sleep 1
    zenity --question --text "Is your Oneplus One in bootloader/fastboot mode now ?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200
    sleep 1
    if [ "$?"==1]; then
  	clear
	zenity --info --title "OSwitcher | Detecting device" --text "We are trying to detecte your device"
	sleep 1
	fastboot devices >~/.AttachedDevices    
    fi
      if grep 'device$\|fastboot$' ~/.AttachedDevices
      then
      zenity --info --title "OSwitcher | Detecting device" --text "Device detected !!!"
        sleep 1
        clear
        zenity --info --title "OSwitcher | Almost Done" --text "Move to your device and follow the instructions on your device to finish the setup"
        sleep 1
        fastboot oem unlock
        sleep 1
        zenity --info --title "OSwitcher | Lock/Unlock bootloader" --text "Bootloader unlocked"
        zenity --info --title "OSwitcher | Info" --text "Cleaning up.."
        rm -f ~/.AttachedDevices
        zenity --info --title "OSwitcher | Bootloader Unlocked" --text "Your Bootloader is Unlocked"
        sleep 1
        exit
      fi
elif [ "$int5" == 'Quit' ]; then
  	rm -f ~/.AttachedDevices
        zenity --info --title "OSwitcher | Info" --text "Quit"
fi
else
	zenity --warning --title "OSwitcher | Invalid Option" --text "You did not choose to lock/unlock your device" --width=300 --height=200
  	exit
