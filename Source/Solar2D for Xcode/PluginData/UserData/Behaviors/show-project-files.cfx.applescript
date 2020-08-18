#!/usr/bin/osascript

-- Solar2D Plugin for Xcode.
-- Copyright © 2016 Jacob Nielsen. All rights reserved.
-- Xcode behaviour script to show Solar2D project sandbox in finder

set scriptingEnabled to enableGUIScripting(true)

if scriptingEnabled then
	
	tell application "Corona Simulator" to activate
	
	tell application "System Events"
		tell process "Corona Simulator"
			click menu item "Show Project Files" of menu 1 of menu bar item "File" of menu bar 1
		end tell
	end tell
	--tell application "Xcode" to activate
end if

on enableGUIScripting(showAlert)
	tell application "System Events" to set isEnabled to UI elements enabled
	if not isEnabled then
		if showAlert is true then
			set scriptRunner to name of current application
			activate
			display alert "Enable GUI Scripting for Xcode?" message "To use Xcode Behavior scripts you must enable GUI Scripting for Xcode. Open System Preferences and grant access by selecting its checkbox in the Accessibility list." buttons {"Cancel", "Open System Preferences"} cancel button "Cancel"
		end if
		openAccessibilityList()
	end if
	return isEnabled
end enableGUIScripting


to openAccessibilityList()
	tell application "System Preferences"
		reveal anchor "Privacy_Accessibility" of pane id "com.apple.preference.security"
		activate
	end tell
end openAccessibilityList



