#!/bin/sh

# test for an existing bus daemon, just to be safe
#if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
	## if not found, launch a new one
#	eval `dbus-launch --sh-syntax --exit-with-session`
#fi
#xfdesktop &
#eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh)
#xfce4-panel &
#xfce4-session &
xset b off
xset s off
xset dpms 0 0 600
xset m 5/4 4
xset r rate 250 30

# Terminate xorg through ctrl-alt-bksp
# Disable caps lock
setxkbmap -option terminate:ctrl_alt_bksp -option ctrl:nocaps
setxkbmap dvorak

# Map unused caps lock to dead_acute, see XCompose file why this is done
xmodmap -e "keycode 66 = dead_acute"
xmodmap ~/.Xmodmap

xsetroot -cursor_name left_ptr
#feh --bg-scale `find ~/wallpapers -type f -print | sort --random-sort | head -n 1`
trayer --monitor primary --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --height 17 --transparent true --tint 0x000000 --alpha 0 &
conky &
#nm-applet --sm-disable &
xrandr --output "DP-4" --right-of "DP-2"
redshift &
#sleep 2 && dropbox-cli start &
exec ~/.xmonad/xmonad-x86_64-linux
