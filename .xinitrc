#!/bin/sh
export LANG="en_US.UTF-8"
export LC_TIME="en_GB.UTF-8"
# export TERMINAL="/usr/bin/kitty"

if [[ "$(hostname)" == "NVC00112" ]]; then
    xrdb -merge ~/.Xresources

    # right monitor in vertical position
    xrandr --output DP-0 --primary --mode 3840x2160 --pos 0x1286 --rotate normal --output DP-1 --off --output DP-2 --mode 3840x2160 --pos 3840x0 --rotate left --output DP-3 --off --output DP-4 --off --output DP-5 --off
fi

~/.bin/fix-keyboard.sh
nm-applet &
thunderbird &
blueman-applet &
dunst & # notification daemon
gnome-keyring-daemon --start & # For Google Chrome
xfce4-clipman & # For xfce4-screenshooter
# xfce4-power-manager &
# picom &

################################
### Launch DE/window manager ###
################################

# dbus-launch: https://wiki.archlinux.org/index.php/Flameshot#Troubleshooting ¯\_(ツ)_/¯
# And more reasons to use dbus-launch https://www.reddit.com/r/i3wm/comments/pd5jpp/what_is_dbuslaunch/
exec dbus-launch /usr/bin/i3

#export XDG_CURRENT_DESKTOP=Budgie:GNOME
#exec budgie-desktop

#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session

#startxfce4

#exec cinnamon-session

#export DESKTOP_SESSION=plasma
#exec startplasma-x11