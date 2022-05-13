REPLY=$(zenity  --list --column="check" --column="Label" --radiolist \
                false "A" \
                true "B" \
                false "C" \
);

zenity --info --text=$REPLY
