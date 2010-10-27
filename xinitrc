#!/bin/sh

#exec ck-launch-session startxfce4

#exec ratpoison

# xmonad

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
setxkbmap -option terminate:ctrl_alt_bksp
xsetroot -cursor_name left_ptr
feh --bg-scale `find ~/wallpapers -type f -print | sort --random-sort | head -n 1`
trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --height 17 --transparent true --tint 0x000000 --alpha 0 &
skype &
pidgin &
conky &
nm-applet --sm-disable &
exec ck-launch-session ~/.xmonad/xmonad-x86_64-linux
