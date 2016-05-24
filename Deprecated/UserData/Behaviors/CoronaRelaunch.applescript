#!/usr/bin/osascript

-- Xcode behaviour script to relaunch Corona simulator

tell application "System Events"
	set simulatorIsRunning to (name of processes) contains "Corona Simulator"
end tell

if simulatorIsRunning = true then
	
	tell application "Corona Simulator" to activate
	
	tell application "System Events"
		tell process "Corona Simulator"
			click menu item "Relaunch" of menu 1 of menu bar item "File" of menu bar 1
		end tell
	end tell
	
	--tell application "Xcode" to activate
	
end if