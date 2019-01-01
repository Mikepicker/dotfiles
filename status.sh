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
b=$(acpi | grep -oP "(\d+)%" | tr -d "\n")
if test -z "$b"
then
  b="-"
fi

# battery icon
case ${b%??} in
  10|[7-9]) bicon="\ue214" ;;
  [4-6]) bicon="\ue213" ;;
  [1-3]) bicon="\ue212" ;;
  *) bicon="\ue211"
esac

# battery charging / discharging
bcharg=$(acpi | grep -oP "(Charging)" | tr -d "\n")
if [[ -n "$bcharg" ]]
then
  bicon="\ue201"
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
d=$(date +'%a %d %b %R')
dicon="\ue226"

echo -e "$wicon $n | $bicon $b | $vicon $v | $dicon $d "
