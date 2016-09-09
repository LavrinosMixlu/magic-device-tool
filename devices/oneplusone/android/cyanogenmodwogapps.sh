clear
zenity --info --title "OSwitcher" --text "Installing Cyanogenmod 13 without Gapps" --width=300 --height=200
sleep 1
zenity --info --title "OSwitcher | Installing Cyanogenmod 13 without Gapps" --text "Please boot your Oneplus One into bootloader/fastboot mode by pressing Power AND Volume Up (+)" --width=300 --height=200
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
  fastboot format cache
  fastboot format userdata
  fastboot reboot-bootloader
  sleep 6
  clear
  zenity --info --title "OSwitcher | Downloading" --text "Downloading TWRP recovery"
  wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~misterq/magic-device-tool/recoverys/twrp-3.0.2-0-bacon.img
  sleep 1
  zenity --info --title "OSwitcher | Downloading" --text "Downloading Cyanogenmod 13.."
  sleep 1
  wget -c --quiet --show-progress --tries=10 https://download.cyanogenmod.org/get/bacon-snapshot.zip
  clear
  zenity --info --title "OSwitcher | Installing" --text "Installing TWRP recovery"
  fastboot flash recovery twrp-3.0.2-0-bacon.img
  sleep 1
  zenity --info --title "OSwitcher | Rebooting" --text "Rebooting device.."
  zenity --warning --title "OSwitcher | Don't disconnect your device" --text "This will take ~35 seconds. Don't disconnect your device!"
  fastboot reboot-bootloader
  sleep 7
  fastboot boot twrp-3.0.2-0-bacon.img
  sleep 20
  adb reboot recovery
  sleep 20
  clear
  zenity --info --title "OSwitcher | Info" --text "Pushing zip's to device"
  sleep 1
  zenity --warning --title "OSwitcher | Don't disconnect your device" --text "Please wait this can take awhile"
  zenity --info --title "OSwitcher | Prompt" --text "You may see a prompt asking you for read/write permissions...Ignore that prompt, the tool will take care of the installation"
  zenity --info --title "OSwitcher | Info" --text "Pushing CM 13 zip"
  adb push -p bacon-snapshot.zip /sdcard/
  zenity --info --title "OSwitcher | Info" --text "Pushing gapps zip"
  adb push -p open_gapps-arm-6.0-nano-20160811.zip /sdcard/
  sleep 1
  zenity --info --title "OSwitcher | Installation Progress" --text "Installing Cyanogenmod.."
  adb shell twrp install /sdcard/bacon-snapshot.zip
  sleep 1
  zenity --info --title "OSwitcher | Installation Progress" --text "Wipe cache.."
  adb shell twrp wipe cache
  adb shell twrp wipe dalvik
  adb reboot
  zenity --warning --title "OSwitcher | Rebooting" --text "The device is now rebooting. Give it time to flash the new ROM. It will boot on its own."
  sleep 5
  zenity --info --title "OSwitcher | Installation Progress" --text "Cleaning up.."
  rm -f ~/.AttachedDevices
  sleep 1
  zenity --info --title "Enjoy your new OS" --text "I wish you to enjoy your new OS"
  sleep 1

else
  zenity --warning --title "OSwitcher | Detecting device" --text "Device not found"
  rm -f ~/.AttachedDevices
  sleep 1
  zenity --info --title "OSwitcher | Info" --text "Back to menu"
  sleep 1
  . ./launcher.sh
fi
