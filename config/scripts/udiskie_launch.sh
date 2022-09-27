#!/usr/bin/bash

# Terminate already running instances
killall -q udiskie

# Wait for Udiskie to close
while pgrep -u $UID -x udiskie > /dev/null; do sleep 1; done

# Launch Udiskie
udiskie -a -n -s &

echo "Udiskie launched..."
