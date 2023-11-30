#!/usr/bin/env bash
set -e # Exit if one of commands exit with non-zero exit code
set -u # Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as an error
set -o pipefail # Any command failed in the pipe fails the whole pipe
# set -x # Print shell commands as they are executed (or you can try -v which is less verbose)

# Also see: https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# disable bouncing Dock icons (except Launchpad) for this account
defaults write com.apple.dock no-bouncing -bool True
# Drag windows with control command click https://www.reddit.com/r/MacOS/comments/k6hiwk/keyboard_modifier_to_simplify_click_drag_of/
defaults write -g NSWindowShouldDragOnGesture YES
# Finder: show full Unix path in the title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES;

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Allow running files downloaded from the internet
sudo spctl --master-disable

killall Dock
