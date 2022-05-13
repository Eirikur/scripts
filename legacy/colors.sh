if [[ "$TERM" ]] && [[ "$TERM" != "dumb" ]]; then
	# highlighting
	creset="\e[0m"
	cbold="\e[1m"
	cunder="\e[4m"
	cblink="\e[5m"

	# regular colors
	cblack="\e[0;30m"    # black
	cred="\e[0;31m"    # red
	cgreen="\e[0;32m"    # green
	cyellow="\e[0;33m"    # yellow
	cblue="\e[0;34m"    # blue
	cmagenta="\e[0;35m"    # magenta
	ccyan="\e[0;36m"    # cyan
	cwhite="\e[0;37m"    # white

	# empahsized (bolded) colors
	cbblack="\e[1;30m"
	cbred="\e[1;31m"
	cbgreen="\e[1;32m"
	cbyellow="\e[1;33m"
	cbblue="\e[1;34m"
	cbmagenta="\e[1;35m"
	cbcyan="\e[1;36m"
	cbwhite="\e[1;37m"

	# background colors
	cbgblack="\e[40m"
	cbgred="\e[41m"
	cbggreen="\e[42m"
	cbgyellow="\e[43m"
	cbgblue="\e[44m"
	cbgmagenta="\e[45m"
	cbgcyan="\e[46m"
	cbgwhite="\e[47m"
fi
