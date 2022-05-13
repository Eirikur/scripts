#!/bin/bash
shopt -s expand_aliases

## exporter is now run by systemd on weathertop.local
# if ! (ssh pi@weathertop.local "pgrep -lf enviroplus_exporter")
# then
#     ssh pi@weathertop.local "nohup python3 /home/pi/environment/enviroplus_exporter/enviroplus_exporter.py </dev/null &>/dev/null & disown"
#     echo 'Exporter launched.'
# else
#     echo 'Exporter was/is running.'
# fi

if ! (pgrep -lf prometheus)
then
    echo 'Trying....'
    ~/Applications/prometheus/prometheus --config.file ~/Configuration/prometheus/p1.config --log.level=debug &>/dev/null & disown
else
    echo 'Prometheus is running.'
fi

       
       



# ssh pi@weathertop.local "nohup python3 /home/pi/environment/enviroplus_exporter/enviroplus_exporter.py </dev/null &>/dev/null & disown"
# alias prometheus='~/Applications/prometheus-2.29.1.linux-amd64/prometheus --config.file ~/Configuration/prometheus/p1.config --log.level=debug &>/dev/null & disown'
# prometheus
# sleep 2
# echo ''
# echo 'Prometheus started.'
