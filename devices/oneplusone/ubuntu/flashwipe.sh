clear
zenity --info --title "OSwitcher" --text "Choose a channel to flash (Will remove existing apps/data)" --width=300 --height=200
sleep 1
opt1="stable channel"
opt2="rc-proposed channel"

opt3="Back to menu"


int1=`zenity --height=275 --list --radiolist --title "OSwitcher | Choose a channel to flash (Will remove existing apps/data)" --text 'Select the channel to flash:' --column 'Select...' --column 'Options' TRUE "$opt1" FALSE "$opt2" FALSE "$opt3" --width=610 --height=300`


if   [ "$int1" == 'stable channel' ]; then
	. ./devices/oneplusone/ubuntu/stablewipe.sh
elif [ "$int1" == 'rc-proposed channel' ]; then
  	. ./devices/oneplusone/ubuntu/rc-proposedwipe.sh
elif [ "$int1" == 'Back to menu' ]; then
  	. ./launcher.sh
else
	zenity --warning --title "OSwitcher | Invalid Option" --text "You did not choose a channel" --width=300 --height=200
  	exit
fi
