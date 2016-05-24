#!/usr/bin/osascript

-- Xcode behavior script bridging Corona simulators build for Android to Xcode.

delay 1
tell application "Corona Simulator" to activate
tell application "System Events"
	keystroke "b" using (command down & shift down)
	delay 0.5
end tell
