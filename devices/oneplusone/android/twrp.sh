clear
zenity --info --title "OSwitcher" --text "Install TWRP recovery" --width=300 --height=200
sleep 1
zenity --info --title "OSwitcher | Install TWRP recovery" --text "Please boot your Oneplus One into bootloader/fastboot mode by pressing Power AND Volume Up (+)" --width=300 --height=200
sleep 2
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
  sleep 1
  clear
  zenity --info --title "OSwitcher | Downloading" --text "Downloading TWRP recovery"
  wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~misterq/magic-device-tool/recoverys/twrp-3.0.2-0-bacon.img
  sleep 2
  zenity --info --title "OSwitcher | Installing" --text "Installing TWRP recovery"
  fastboot flash recovery ./twrp-3.0.2-0-bacon.img
  fastboot reboot-bootloader
  sleep 4
  zenity --info --title "OSwitcher | Boot Option" --text "You can now boot into TWRP recovery"
  sleep 1
  zenity --info --title "OSwitcher | Installation Progress" --text "Cleaning up.."
  rm -f ~/.AttachedDevices
  #rm -f ./*.img
  sleep 1
  zenity --info --title "OSwitcher | Info" --text "Exiting script. Bye Bye"
  sleep 1
  exit

else

  zenity --warning --title "OSwitcher | Detecting device" --text "Device not found"
  rm -f ~/.AttachedDevices
  sleep 1
  . ./launcher.sh
fi
