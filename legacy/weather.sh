#!/bin/bash
shopt -s expand_aliases


echo 'Trying....'
~/Applications/prometheus/prometheus --config.file ~/Configuration/prometheus/p1.config --log.level=debug --web.listen-address=localhost:9191 &>/dev/null & disown
echo 'Prometheus presumed to have been started.'
ps -e | grep prometheus

