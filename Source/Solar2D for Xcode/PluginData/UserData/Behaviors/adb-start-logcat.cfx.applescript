#!/usr/bin/osascript

(*
Xcode behaviour script to start Android adb logcat.
*)

property buildFolder : (the POSIX path of (path to desktop folder as text))
property adbPath : "/Applications/Solar2D/Corona Simulator.app/Contents/Resources/device-support"

set scriptingEnabled to enableGUIScripting(true)

if scriptingEnabled then
	set devices to do shell script "cd " & (quoted form of adbPath) & "; ./adb devices"
	set devices to replace_chars(devices, "devices", "")

	if devices contains "device" then
		tell application "Terminal"
	    	do script "'/Applications/Solar2D/Corona Simulator.app/Contents/Resources/device-support/adb' logcat -v raw Corona:D ActivityManager:W AndroidRuntime:E '*:S'"
		end tell
	else
		display dialog "Android device not found.\nConnect a device to the computer with usb." with title "Error" with icon caution buttons {"OK"}
	end if
end

-- string replace
on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

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
