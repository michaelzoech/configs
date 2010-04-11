#!/bin/sh

#exec ck-launch-session startxfce4

#exec ratpoison

# xmonad
xfdesktop &
xfce4-panel &
xset b off
xfce4-session &
#nm-applet --sm-disable &
exec ~/.xmonad/xmonad
