#!/bin/bash
#
# Alarm clock for PCLinuxOS
#
# Don't miss important times and events. Turn your computer
# into the perfect wake up system. Set the alarm and get the
# Pizza out of the oven in perfect time.
#
# Author: D.M-Wilhelm (Leiche)
# Email: meisssw01 at gmail.com
# Licence: GPL
# First build: May Wed 11 2011
# Last build: Jul Sun 10 2011
# fixed icon display in systray, move zenity,
# based now on yad.
#
Encoding=UTF-8
#
# i18n - Internationalization - Internationalisierung
#
export TEXTDOMAIN=alert_clock
export TEXTDOMAINDIR="/usr/share/locale"
#
# define some variables - Definierung einiger Variablen
#
TITLE=alert_clock
VERSION=0.32
ICON=/usr/share/icons/wecker.png

#
#question - Frage
#
function menu {
COUNTDOWN=$(yad --entry --text $"Enter minutes...!" --title="$TITLE"" $VERSION" --window-icon=$ICON \
                        --image=$ICON \
                        --button=$"Change:2" \
                        --button=$"Test:3" \
                        --button="gtk-ok:0" \
                        --button="gtk-close:1" \
                   )
ret=$?

[[ $ret -eq 1 ]] && exit 0
#
#change sound - Sound ändern
#
if [[ $ret -eq 2 ]]; then
    CHANGE=$(yad --title="$TITLE"" $VERSION" --window-icon=$ICON \
                --file --width=600 --height=500 \
                --text=$"<b>Choose your own audio file as alert!</b>
________________________________________________")
                if [ -z "$CHANGE" ];then
                exec alert_clock
                exit 0
                else
                mkdir $HOME/.config/alert-clock
                rm -rf $HOME/.config/alert-clock/alert sleep 1
                ln -s "$CHANGE" $HOME/.config/alert-clock/alert
                yad --title $"$TITLE"" $VERSION" \
            --button="gtk-ok:0" \
            --width 300 \
            --window-icon=$ICON \
            --text=$"Your own sound is set!!"
                fi
menu
fi
#
#Test sound - Klang testen
#
if [[ $ret -eq 3 ]]; then
        if [ -f $HOME/.config/alert-clock/alert ]; then
        SOUND="$HOME/.config/alert-clock/alert"
        else
        SOUND='/usr/share/alert_clock/alarm.ogg'
        fi
mplayer "$SOUND" | yad --title $"$TITLE"" $VERSION" \
                 --button="gtk-ok:0" \
                 --width 300 \
                 --window-icon=$ICON \
                 --text=$"Exit sound test!!"
killall mplayer
menu
fi
}
menu
#
#progress - Prozess
#
if [ "$COUNTDOWN" = "" ];then
exit
else
echo you enter "$COUNTDOWN" minutes
TIMER=$(echo $(($COUNTDOWN*60)))
TASK1=$(date -s "+$TIMER seconds" 2>/dev/null | cut -d " " -f4)
exec 3> >(yad --notification --command=CMD --image=$ICON --listen)
echo tooltip: $"Alarm clock was set to $COUNTDOWN minutes and notifiers at $TASK1!" >&3
sleep $TIMER
exec 3>&-
#
#check wich sound - auf Audio prüfen
#
if [ -f $HOME/.config/alert-clock/alert ]; then
        SOUND="$HOME/.config/alert-clock/alert"
        else
        SOUND='/usr/share/alert_clock/alarm.ogg'
fi
#
#alert output - Alarm Ausgabe
#
(mplayer -loop 0 "$SOUND") | yad --title $"$TITLE"" $VERSION" \
                 --button="gtk-ok:0" \
                 --width 300 --image=$ICON \
                 --window-icon=$ICON \
                 --text=$"<b>Time is over!!</b>"
                 exit;
fi
exit
