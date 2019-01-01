# fonts
xset fp rehash

setxkbmap it

export _JAVA_AWT_WM_NONREPARENTING=1

# setxkbmap it
xautolock -time 10 -locker slock &
xsetroot -solid "#3b4252"

while xsetroot -name "$(~/status.sh)"
do
  sleep 1
done &

exec dwm

# office monitor
# xrandr --output VGA-1-2 --auto --output HDMI-1 --auto --above LVDS-1
