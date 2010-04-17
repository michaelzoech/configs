#!/bin/sh

#exec ck-launch-session startxfce4

#exec ratpoison

# xmonad

# test for an existing bus daemon, just to be safe
if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
	## if not found, launch a new one
	eval `dbus-launch --sh-syntax --exit-with-session`
fi
#xfdesktop &
eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh)
xfce4-panel &
xset b off
xfce4-session &
#nm-applet --sm-disable &
setxkbmap -option terminate:ctrl_alt_bksp
exec ~/.xmonad/xmonad-x86_64-linux
