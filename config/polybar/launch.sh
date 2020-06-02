#!/usr/bin/env sh

# terminate already running bar instances
killall -q polybar

# wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bar1 and bar2
# polybar top -c ~/.config/polybar/config-top.ini &
polybar bottom -c ~/.config/polybar/config-bottom.ini &
