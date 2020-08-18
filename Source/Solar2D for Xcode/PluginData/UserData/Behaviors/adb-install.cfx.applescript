#!/usr/bin/osascript

(*
Xcode behaviour script to install apk files to Android device via adb.
*)

property buildFolder : (the POSIX path of (path to desktop folder as text))
property adbPath : "/Applications/Solar2D/Corona Simulator.app/Contents/Resources/device-support"

set scriptingEnabled to enableGUIScripting(true)

if scriptingEnabled then

	set devices to do shell script "cd " & (quoted form of adbPath) & "; ./adb devices"
	set devices to replace_chars(devices, "devices", "")

	if devices contains "device" then
		install_apk()
	else
		display dialog "Android device not found.\nConnect a device to the computer with usb." with title "Error" with icon caution buttons {"OK"}
	end if
end

-- install apk
on install_apk()
	set apk to choose file with prompt "Choose .apk to install to device:" of type {"apk"} default location buildFolder
	set apkPath to (the POSIX path of apk)
	delay 0.5
	
	try
		set response to do shell script "cd " & (quoted form of adbPath) & "; ./adb install " & apkPath
		if response contains "ALREADY_EXISTS" then
			set button to (display dialog "Do you want to replace existing file on the device?" with icon 2)
			if button = {button returned:"OK"} then
				set response to do shell script "cd " & (quoted form of adbPath) & "; ./adb install -r " & apkPath
				complete(response, apkPath)
			end if
		else
			complete(response, apkPath)
		end if
		
	on error errorDescription
		if errorDescription contains "User cancelled" then
		else
			display dialog {errorDescription} as text buttons {"OK"}
		end if
	end try
	
end install_apk

-- Install complete
on complete(response, apkPath)
	if response contains "Success" then
		display dialog "Successfully installed: " & apkPath buttons {"OK"}
	else
		display dialog response buttons {"OK"}
	end if
end complete

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
