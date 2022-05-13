#!/bin/bash
#

SOURCE='alsa_input.usb-neat_Beecaster-00.analog-stereo'

echo "Setting default source to: $SOURCE";
pacmd set-default-source $SOURCE
# pacmd list-sink-inputs | grep index | while read line
# do
#     # echo "Moving input: ";
#     # echo $line | cut -f2 -d' ';
#     # echo "to sink: $SINK";
#     pacmd move-sink-input `echo $line | cut -f2 -d' '` $SINK
# done


