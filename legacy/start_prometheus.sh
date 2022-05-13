#!/bin/bash
shopt -s expand_aliases


if ! (pgrep -lf prometheus)
then
    echo 'Trying....'
    ~/Applications/prometheus/prometheus --config.file ~/Configuration/prometheus/p1.config --log.level=debug --web.listen-address=localhost:9191
    ##### &>/dev/null & disown
    echo 'Prometheus presumed to have been started.'
    ps -e | grep -p prometheus
else
    echo 'Prometheus is running.'
fi
