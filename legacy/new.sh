#!/bin/bash

for dir in .config .ssh .cinnamon .emacs.d .gkrellm2 \
                   .fonts .github .local .mozilla \
                   .wmWeatherReports scripts Configuration Customization \
                   .themes Applications ;
do
    echo "$dir"
    rm -rf "$dir" -v #  &>/dev/null
    /usr/bin/time -f%E rsync  -haAX  --inplace --info=progress2 \
              --exclude='*.img' --exclude='Trash' \
              --exclude='Downloads' \
              --exclude='Instruments' \
              --exclude=cache --exclude=cache2 --exclude='.cache' \
              --exclude='*.iso' --exclude='*.tar' \
              --exclude='saved-telemetry-pings' \
              -e "ssh -T -c aes128-ctr -o Compression=no -x" \
              "tma-1.local:$dir" ~/
done



 
