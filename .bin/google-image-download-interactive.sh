#!/usr/bin/env bash
set -e # Exit if one of commands exit with non-zero exit code
set -u # Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as an error
# set -v # Print shell input lines as they are read (You may also try -x which is more verbose)

read input

session="google-image-download-interactive"

mkdir -p fucking-downloads

tmux new-session -d -s $session
tmux send-keys -t $session:1 "googleimagesdownload -o fucking-downloads -la Dutch -k '$input'" ENTER
tmux split-window -v -t $session
tmux send-keys -t $session:1 "nnn fucking-downloads -p /tmp/nnn-fucking-choice && tmux kill-session -t $session" ENTER
tmux send-keys -t $session:1 ";t" ENTER # Enable nnn preview
alacritty -e tmux attach -t "$session"

input_without_spaces=$(echo "$input" | tr ' ' '-')
filename=$(cat /tmp/nnn-fucking-choice)
ext=$(echo "$filename" | sed -E 's/.*\.(.*)/\1/')
mv "$filename" "$input_without_spaces.$ext"
rm -rf fucking-downloads
echo "./$input_without_spaces.$ext"

