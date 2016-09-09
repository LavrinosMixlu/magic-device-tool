clear
zenity --info --title "OSwitcher" --text "Flashing stable channel" --width=300 --height=200
sleep 1
zenity --info --title "Boot into fastboot mode" --text "Press Power AND Volume Up (+) " --width=300 --height=200
echo ""
sleep 1
zenity --question --text "Is your OnePlus One in fastboot mode now?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200 
sleep 1
#echo $? returns 0 for Nope and 1 for Yeap
if [ "$?"==1]; then
  clear
  zenity --info --title "OSwitcher | Detecting device" --text "We are trying to detecte your device"
  sleep 1
  fastboot devices >~/.AttachedDevices
fi
  if grep 'device$\|fastboot$' ~/.AttachedDevices
  then
    zenity --info --title "OSwitcher | Detecting device" --text "Device detected !!!"
    sleep 2
    clear
    zenity --info --title "OSwitcher | Flashing your device" --text "Flashing stable channel"
    sleep 2
    fastboot format cache
    fastboot format userdata
    fastboot reboot-bootloader
    sleep 6
    sudo ubuntu-device-flash --server=http://system-image.ubports.com touch --channel=ubuntu-touch/stable --device=bacon --bootstrap
    zenity --info --title "OSwitcher | Almost Done" --text "Move to your device to finish the setup."
    sleep 1
    rm -f ~/.AttachedDevices
    sleep 2
    zenity --info --title "OSwitcher | Enjoy your new OS" --text "Enjoy your new OS"
    sleep 1
    exit
    else
    zenity --warning --title "Enjoy your new OSDetecting device" --text "Device not found"
    rm -f ~/.AttachedDevices
    sleep 2
    zenity --info --title "Info" --text "Back to menu"
    sleep 1
    . ./launcher.sh
fi
