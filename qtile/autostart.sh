#! /bin/sh

picom &
feh --bg-fill ~/Pictures/Wallpapers/current.jpg &
setxkbmap -layout pt,us -variant ,altgr-intl -option grp:shifts_toggle
xbindkeys

