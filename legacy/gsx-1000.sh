#!/bin/bash

#SINK='alsa_output.usb-Sennheiser_GSX_1000_Main_Audio_5698800337010068-00.analog-surround-71'
# SINK='alsa_output.usb-Sennheiser_GSX_1000_Main_Audio_5698800337010068-00.analog-output-surround71'
SINK='alsa_output.usb-Sennheiser_GSX_1000_Main_Audio_5698800489044473-00.analog-output-surround71'


echo "Setting default sink to: $SINK";
pacmd set-default-sink $SINK
pacmd list-sink-inputs | grep index | while read line
do
    INPUT=$(echo $line | cut -f2 -d' ')

    echo "Moving input: $INPUT to sink: $SINK."
    # echo ($line | cut -f2 -d' ');
    # echo "to sink: $SINK";
    pacmd move-sink-input `echo $line | cut -f2 -d' '` $SINK
done



