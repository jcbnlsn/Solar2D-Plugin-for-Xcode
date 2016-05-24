#!/usr/bin/osascript

(*
Xcode behaviour script to open active Xcode project in the Corona Simulator.

This script assumes that the CoronaSDK folder is installed in the
applications folder. If you installed it somewhere else you need
to change the coronaPath property below.

This script only works if your xcodeproject file and the folder with
your corona project files resides in the same folder and have the same name.
*)

property coronaPath : (path to applications folder as text) & "CoronaSDK:Corona Simulator"

tell application "Xcode"
	
	tell front project -- first changed to front. allows multiple projects open
		set targetProject to (get project directory)
		set projectName to (get name)
		set pbxFile to targetProject & "/" & projectName & ".xcodeproj/project.pbxproj"
		
		set projectPath to targetProject & "/" & projectName
		--display dialog projectPath
	end tell
end tell

set scriptingEnabled to enabledGUIScripting(true)

if scriptingEnabled then
	tell application "System Events" to set simulatorIsRunning to (name of processes) contains "Corona Simulator"
	
	if simulatorIsRunning = false then
		
		(*
		Uncomment shell script below to lua syntax color 
		whole Xcode project on each simulator launch
		*)
		--do shell script "perl -pi -w -e 's/lastKnownFileType = sourcecode.lua;/lastKnownFileType = sourcecode.corona; xcLanguageSpecificationIdentifier = xcode.lang.lua;/g' " & pbxFile
		
		tell application "Finder" to open coronaPath
		delay 2
		tell application "Corona Simulator" to open projectPath
	else
		tell application "Corona Simulator" to open projectPath
	end if
	
	(*
	Remove the 2 lines below if you want Corona Simulator window to have 
	focus ( instead of Xcode ) after launching it.
	*)
	delay 0.5
	tell application "Xcode" to activate
end if

-- Enable assistive devices for Xcode
on enabledGUIScripting(flag)
	get system attribute "sysv"
	if result is less than 4240 then -- 4240 is OS X 10.9.0 Mavericks
		
		tell application "System Events"
			activate -- brings System Events authentication dialog to front
			set UI elements enabled to flag
			return UI elements enabled
		end tell
	else
		
		tell application "System Events" to set GUIScriptingEnabled to UI elements enabled -- read-only in OS X 10.9 Mavericks
		if flag is true then
			if not GUIScriptingEnabled then
				activate
				set scriptRunner to name of current application
				display alert "GUI Scripting is not enabled for " & scriptRunner & "." message "Open System Preferences, unlock the Security & Privacy preference, select " & scriptRunner & " in the Privacy Pane's Accessibility list, and then run this script again." buttons {"Open System Preferences", "Cancel"} default button "Cancel"
				if button returned of result is "Open System Preferences" then
					tell application "System Preferences"
						tell pane id "com.apple.preference.security" to reveal anchor "Privacy_Accessibility"
						activate
					end tell
				end if
			end if
		end if
		return GUIScriptingEnabled
	end if
end enabledGUIScripting

