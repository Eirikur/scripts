Subject:    Re: [PATCH v2] USB: add support for Dream Cheeky DL100B Webmail Notifier (1d34:0004)
From:       Melchior FRANZ <melchior.franz () gmail ! com>
Date:       2010-12-22 20:54:34
Message-ID: 201012222154.34943 () rk-nord ! at
[Download message RAW]

Here's some "bonus material":
- one of my little "Alarm Scripts" attached; it creates fancy blue
  double flashes, as police/ambulance cars often have them here in Austria
- I suggested in my patch description that the circuit board could be
  put into a nicer case. I've done that and documented it here:
  http://picasaweb.google.com/melchior.franz/Dream_cheeky_webmail_notifier
  Please excuse the really bad photo quality. Note, however, that it looks
  very good in Real Life.  :-)

Sorry for (almost) being OT.

m.

["flash" (application/x-shellscript)]

#!/bin/bash
DIR=/sys/bus/usb/drivers/usbled
if ! [ -d $DIR ]; then
	echo "usbled devices not supported (CONFIG_USB_LED)" >&2
	exit 1
fi

cd $DIR

set -a DEV
DEV=($(ls -d [0-9]* 2>/dev/null))
if [ ${#DEV[@]} == 0 ]; then
	echo "no usbled device attached" >&2
	exit 2
fi

blue() {
	for dev in ${DEV[*]}; do
		echo $1 2>/dev/null >$dev/blue || echo "error writing $PWD/$dev/blue"
	done
}

trap 'blue 0; exit' 0 1 2 3 13 15

while true; do
	blue 31
	usleep 40000
	blue 0
	usleep 80000
	blue 31
	usleep 40000
	blue 0
	usleep 1200000
done
