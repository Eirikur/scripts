DISPLAY=$(xrandr | grep "connected primary" | awk '{print $1}')
