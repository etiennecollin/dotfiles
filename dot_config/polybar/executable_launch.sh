#!/usr/bin/bash

# Terminate already running bar instances
killall -q polybar
# polybar-msg cmd quit

# Wait for Polybar to close
#while sudo pgrep -u $UID -x polybar > /dev/null; do sleep 1; done
while sudo pgrep -x polybar >/dev/null; do sleep 1; done

# Launch Polybar
polybar --reload main -c ~/.config/polybar/config.ini &

echo "Bar launched..."
