#!/bin/bash

# network
ssid=$(iwgetid -r)
if test -n "$ssid"
then
  n="$ssid"
else
  n=""
fi

# signal strength
ss=$(iwconfig wlp3s0 | sed -n 's/^.*Quality=//p' | sed -n 's/\/.*//p' | tr -d '\n')
if ((ss > 50))
then
  wicon="\ue222"
elif ((20 <= ss && ss <= 50))
then
  wicon="\ue221"
else
  wicon="\ue220"
fi

# battery
b1=$(acpi | grep -oP "(\d+)%" | sed -n '1p' | tr -d "%" | tr -d "\n")
if test -z "$b1"
then
  b1="-"
fi

b2=$(acpi | grep -oP "(\d+)%" | sed -n '2p' | tr -d "%" | tr -d "\n")
if test -z "$b2"
then
  b2="-"
fi

# battery icon
bwarn=""
if ((b1 < 15 && b2 < 15))
then
  bwarn="!"
fi

# battery charging / discharging
bcharg=$(acpi | grep -oP "(Charging)" | tr -d "\n")
bicon="-"
if [[ -n "$bcharg" ]]
then
  bicon="+"
fi

# volume
v=$(amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq)%

# volume icon
case ${v%??} in
  10|[5-9]) vicon="\ue05d" ;;
  [1-4]) vicon="\ue050" ;;
  *) vicon="\ue04e"
esac

# Volume toggle
voff=$(amixer get Master | grep -i 'off')
if test -n "$voff"
then
  vicon="\ue04f"
fi

# Date
d=$(date +'%a %d %b %R' | tr '[:upper:]' '[:lower:]')
dicon="\ue226"

echo "w $n | b$bicon$bwarn $b1% $b2% | v $v | $d "
