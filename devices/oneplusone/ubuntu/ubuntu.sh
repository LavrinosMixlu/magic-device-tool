clear
zenity --info --title "OSwitcher" --text "Install Ubuntu" --width=300 --height=200
sleep 1
opt1="Choose a channel"
opt2="Back to menu"


int4=`zenity --height=275 --list --radiolist --title "Choose a channel to flash (Will remove existing apps/data)" --text 'Select the channel to flash:' --column 'Select...' --column 'Options' TRUE "$opt1" FALSE "$opt2" --width=610 --height=300`


if   [ "$int4" == 'Choose a channel' ]; then
	. ./devices/oneplusone/ubuntu/flashwipe.sh
elif [ "$int4" == 'Back to menu' ]; then
  	. ./launcher.sh
else
	zenity --warning --title "OSwitcher | Invalid Option" --text "You did not choose a channel" --width=300 --height=200  	
  	exit
fi
