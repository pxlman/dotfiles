#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
$HOME/.config/scripts/autostart.sh
xsetroot -cursor_name left_ptr
setxkbmap -option grp:alt_shift_toggle us,ara &
redshift -l 30:31.2 -P -t 4000:3750 & 
nitrogen --restore &
#$HOME/.config/polybar/launch.sh &
picom --config $HOME/.config/picom/picom.conf &
xinput set-prop "DELL0979:00 04F3:30C4 Touchpad" "libinput Tapping Enabled" 1 &
xinput set-prop "DELL0979:00 04F3:30C4 Touchpad" "libinput Natural Scrolling Enabled" 1 &
# exec qtile start
nm-applet &
brightnessctl set 15% &
~/.conky/conky-startup.sh &
exec bspwm 

#exec --no-startup-id picom -b --experimental-backend --transparent-clipping --config /home/pxlman/.config/picom/picom.conf 
