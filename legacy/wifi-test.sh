#!/bin/bash
# WIFI: announcement and discussion here: https://bbs.archlinux.org/viewtopic.php?id=143098

#Check for terminal type
if [[ -z $DISPLAY ]]; then
	[[ `which wifi_tty 2>/dev/null` ]] && exec wifi_tty
	[[ -x `dirname $0`/wifi_tty ]] && exec `dirname $0`/wifi_tty
	echo "wifi may not run properly on a tty terminal.  Please use wifi_tty"
	exit
fi

# COLOR SETTINGS (0-255):
#  Uncomment one, or create your own.
COL_TFRAME=247; COL_TTEXT=241;	COL_H1=12;	COL_H2=226;	COL_WARN=196	#Bright (grey,blue,yellow)
#COL_TFRAME=22; COL_TTEXT=115;	COL_H1=90;	COL_H2=94;	COL_WARN=196	#Dark (green,magenta,orange)

# DHCP choose dhcpcd or dhclient, only the former has been tested by the script author
DHCP=dhcpcd

# Set new passphrase if provided:
if [[ $1 == new ]]; then
	[[ -z $2 ]] && echo "required ssid missing" && exit
	[[ -z $3 ]] && echo "required passphrase missing" && exit
	sudo /bin/bash -c "wpa_passphrase \"$2\" \"$3\" >> /etc/wpa_supplicant.conf"
fi

# Get current BSSID to highlight it in the list
CUR_BSSID=`iwconfig wlan0 | awk '/Access Point:/ {print $6}'`

# Create temp file for network listing
TMPFILE=`mktemp --tmpdir=/tmp wifilistXXX`

# bring up wlan0, scan, and parse output with awk for display:
#    Also saves needed scan output into tempfile
clear
sudo ip link set wlan0 up
sudo iwlist wlan0 scan | awk '
BEGIN {
	print " \033[4;38;5;'$COL_TFRAME'm                                                 \033[0m"
	print " \033[4;38;5;'$COL_TFRAME'm\033(0aaaaaaaaaaaaa\033(B  SCANNING NETWORKS... \033(0aaaaaaaaaaaaa\033(B\033[0m"
	print " \033[4;38;5;'$COL_TFRAME'm* # BSSID              %  ESSID                  \033[0m"
}
/^[ \t]*Cell / {
	NUM=$2; BSSID=$5;
	getline; getline; getline;
	gsub(/[ \t]*Quality=/,"",$1);
	QUALITY=$1 * 100 / 70;
	getline;
	gsub(/key:/,"",$2);
	ENCRYPTION=$2;
	getline;
	gsub(/[ \t]*ESSID:/,"",$1);gsub(/"/,"",$0);
	ESSID=$0;

	if (match(BSSID,"'$CUR_BSSID'")) {
		printf " \033[38;5;'$COL_H1'm»"
	} else {
		printf "  "
	}

	if (match(ENCRYPTION,"off")) {
		printf "\033[38;5;'$COL_H2'm%2d\033[38;5;'$COL_TTEXT'm %s \033[38;5;'$COL_H2'm%d%%\033[38;5;'$COL_H1'm %s\033[0m\n", NUM, BSSID, QUALITY, ESSID;
	} else {
		printf "\033[38;5;'$COL_H2'm%2d\033[38;5;'$COL_TTEXT'm %s \033[38;5;'$COL_H2'm%d%%\033[38;5;'$COL_WARN'm %s\033[0m\n", NUM, BSSID, QUALITY, ESSID;
	}
	printf "%s\t%s\t%s\n", NUM, ENCRYPTION, ESSID >> "'$TMPFILE'"
}
END {
	print " \033[4;38;5;'$COL_TFRAME'm\033(0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\033(B\033[0m"
}
'

# prompt for network selection - exit (do nothing) if no selecion is made:
echo
echo -e " \033[38;5;"$COL_H1"mSelect a network number:\033[0m"
read -p " » " NUM
if [[ -z $NUM ]]; then rm $TMPFILE; exit; fi

# get data for selection from tempfile and delete tempfile:
ESSID=`awk -F'\t' '/^0?'$NUM'	/ {print substr($0,index($0,$3))}' $TMPFILE`
ENCRYPT=`awk -F'\t' '/^0?'$NUM'	/ {print $2}' $TMPFILE`
rm $TMPFILE


# if wpa_supplicant is already running, kill it
if [[ -n `pgrep wpa_supplicant` ]]; then
	sudo killall wpa_supplicant > /dev/null 2>&1
	sleep 0.25
fi
# if unsecure, associate with essid.  If secure, use wpa_supplicant:
if [[ "$ENCRYPT" == off ]]; then
	sudo iwconfig wlan0 essid "$ESSID"
else
	#check if configured:
	[[ ! `grep "$ESSID" /etc/wpa_supplicant.conf` ]] &&
		echo -e "\033[38;5;'$COL_WARN'm  ERROR:\033[0m$ESSID has not been set up yet\n  Try: $0 new \"$ESSID\" <passphrase>" && exit
	sudo wpa_supplicant -B -c/etc/wpa_supplicant.conf -iwlan0
fi

# if dhcpcd is already running, kill it.
if [[ -n `pgrep $DHCP` ]]; then
	sudo killall $DHCP >/dev/null 2>&1
	sleep 0.25
fi
# call dhcpcd
sudo $DHCP wlan0 2>&1 | awk '
BEGIN {
	print " \033[4;38;5;'$COL_TFRAME'm                                                 \033[0m"
	print " \033[4;38;5;'$COL_TFRAME'm\033(0aaaaaaaaaaaaaa\033(B  CALLING DHCPCD... \033(0aaaaaaaaaaaaaaa\033(B\033[0;38;5;'$COL_TTEXT'm"
}
// {
	gsub(/dhcpcd\[[0-9]*\]: /,"",$0); gsub(/wlan0: /,"",$0);
	gsub(/([0-9]+\.[0-9]+\.[0-9]+.[0-9]+)/,"\033[38;5;'$COL_H2'm&\033[38;5;'$COL_TTEXT'm",$0);
	gsub(/( [0-9]+[^\.])/,"\033[38;5;'$COL_H1'm&\033[38;5;'$COL_TTEXT'm",$0);
	if (match($0,/dhcpcd already running/)) {
		print "  \033[38;5;'$COL_WARN'mERROR: \033[38;5;'$COL_TTEXT'mdhcpcd already running"
		print "  \033[38;5;'$COL_H2'mretrying dhcpcd"
		exit 1
	} else {
		print " \033[38;5;'$COL_H1'm»\033[38;5;'$COL_TTEXT'm", $0;
	}
}
END {
	print " \033[4;38;5;'$COL_TFRAME'm\033(0aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\033(B\033[0m\n"
}
'

