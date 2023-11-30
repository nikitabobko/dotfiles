#!/usr/bin/env bash
set -e # Exit if one of commands exit with non-zero exit code
set -u # Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’ as an error
set -o pipefail # Any command failed in the pipe fails the whole pipe
# set -x # Print shell commands as they are executed (or you can try -v which is less verbose)

getWindowTitleOnMacOs() {
# taken from user Albert's answer on StackOverflow
# http://stackoverflow.com/questions/5292204/macosx-get-foremost-window-title
# tested on Mac OS X 10.7.5
cat <<EOF | osascript
global frontApp, frontAppName, windowTitle

set windowTitle to ""
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    set frontAppName to name of frontApp
    tell process frontAppName
        tell (1st window whose value of attribute "AXMain" is true)
            set windowTitle to value of attribute "AXTitle"
        end tell
    end tell
end tell

return {frontAppName, windowTitle}
EOF
}

if isMacOs; then
    getWindowTitleOnMacOs
else
    xdotool getwindowfocus getwindowname
fi
