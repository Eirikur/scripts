#!/bin/bash
#
# Use pacmd. Better results?

# pacmd set-default-source set-default-sink


# #!/bin/bash 

# echo "Setting default sink to: $1";
# pacmd set-default-sink $1
# pacmd list-sink-inputs | grep index | while read line
# do
# echo "Moving input: ";
# echo $line | cut -f2 -d' ';
# echo "to sink: $1";
# pacmd move-sink-input `echo $line | cut -f2 -d' '` $1

# done

pacmd set-default-source alsa_input.usb-0a12_Avantree_DG60_ABCDEF0123456789-00.analog-mono
pacmd set-default-sink alsa_output.usb-0a12_Avantree_DG60_ABCDEF0123456789-00.analog-stereo
