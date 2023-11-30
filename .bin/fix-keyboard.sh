#!/usr/bin/env bash

# This is a separate script because it allows me to hit alt+space (invoke spotlight) and type "fix-keyboard" to fix every new
# keyboard I connect to the computer. Those are primary bluetooth keyboards, so it happens that they disconnect pretty often
# (typically on timeout)

set -e # Exit if one of commands exit with non-zero exit code
set -u # Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as an error
#set -x # Print shell commands as they are executed (or you can try -v which is less verbose)

xset r rate 160 90 # Key repeat first number is delay second is repeat speed
xset s off # Turn off screensaver

# setxkbmap. See /usr/share/X11/xkb/rules/base
# setxkbmap -option altwin:swap_alt_win # swap alt and super keys
# setxkbmap -option caps:escape # remap caps lock to esc

setxkbmap -option ctrl:nocaps # remap caps lock to ctrl
killall xcape &> /dev/null || true
xcape -e 'Control_L=Escape' # make left ctrl (and caps lock too) behave as escape when pressed on it's own

setxkbmap -layout us,ru -option grp:win_space_toggle

