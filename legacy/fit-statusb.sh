#!/bin/bash
sudo stty -F /dev/ttyACM0 9600 raw -echo -echoe -echok -echoctl -echoke

command="$1"

# echo "tput reset > /dev/ttyACM0" | sudo su

led_cmd () {
    cmd_string="echo \"$command\" > /dev/ttyACM0"
    echo "$cmd_string"
    echo "$cmd_string" | sudo su
}

led_cmd "$command"
