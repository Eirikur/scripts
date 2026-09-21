 #!/bin/bash

while true; do
    emacs --fg-daemon
    notify-send "Emacs exited. Restarting..."
    sleep 1
done
