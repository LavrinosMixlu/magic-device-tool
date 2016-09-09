clear
zenity --info --title "OSwitcher" --text "Flashing rc-proposed channel" --width=300 --height=200
sleep 1
zenity --info --title "OSwitcher | Boot into fastboot mode" --text "Press Power AND Volume Up (+) " --width=300 --height=200
echo ""
sleep 2
zenity --question --text "Is your OnePlus One in fastboot mode now?" --ok-label "Nope" --cancel-label="Yeah" --width=300 --height=200
sleep 1
#echo $? returns 0 for Nope and 1 for Yeap
if [ "$?"==1]; then
  clear
  zenity --info --title "Detecting device" --text "We are trying to detecte your device"
  sleep 1
  fastboot devices >~/.AttachedDevices
fi
  if grep 'device$\|fastboot$' ~/.AttachedDevices
  then
    zenity --info --title "Detecting device" --text "Device detected !!!"
    sleep 2
    clear
    zenity --info --title "Flashing your device" --text "Flashing rc-proposed channel"
    sleep 2
    fastboot format cache
    fastboot format userdata
    fastboot reboot-bootloader
    sleep 6
    sudo ubuntu-device-flash --server=http://system-image.ubports.com touch --channel=ubuntu-touch/rc-proposed --device=bacon --bootstrap
    zenity --info --title "Almost Done" --text "Move to your device to finish the setup."
    sleep 2
    rm -f ~/.AttachedDevices
    sleep 2
    zenity --info --title "Enjoy your new OS" --text "Exiting script. Bye Bye"
    sleep 1
    exit
    else
    zenity --warning --title "Detecting device" --text "Device not found"
    rm -f ~/.AttachedDevices
    sleep 2
    zenity --info --title "Info" --text "Back to menu"
    sleep 1
    . ./launcher.sh
fi
