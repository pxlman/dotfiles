# Statusbar loop
while true; do
   xsetroot -name "$( date +"%F %R" )"
   sleep 20    # Update time every minute
done &

# Set Tapping in touchpad
# Set Natural scrolling to true
$HOME/.mycmds/touchSettings

# Set layouts us,ara
setxkbmap -option grp:alt_space_toggle us,ara
# Set cursor name as blabla to make lxapprarance change cursor
xsetroot -cursor_name left_ptr &
# Night light redshift
redshift -t 5000:4000 P -l 30:31 -m randr&
# Picom for fading and transparency
picom --config ~/.config/picom/picom.conf.bak&
# Nitrogen for wallpapers
nitrogen --restore&
# The bindings program
exec sxhkd &
# The window manager
exec bspwm
