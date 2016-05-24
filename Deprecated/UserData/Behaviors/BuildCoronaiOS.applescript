#!/usr/bin/osascript

-- Xcode behavior script bridging Corona simulators build for iOS to Xcode.

tell application "Corona Simulator" to activate
delay 1
tell application "System Events"
	keystroke "b" using (command down)
end tell


