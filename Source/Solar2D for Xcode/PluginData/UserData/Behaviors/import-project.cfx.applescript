#!/usr/bin/osascript
(*
Solar2D Plugin for Xcode.
Copyright  2017 Jacob Nielsen. All rights reserved.
Xcode behaviour script to generate xcodeproj file for Solar2D projects
*)

property sampleCodePath : (the POSIX path of (path to applications folder as text)) & "Solar2D/SampleCode"
property templatePath : (the POSIX path of (path to home folder as text)) & "/Library/Developer/Xcode/Templates/CFXTemplate/___CFX_PROJECT_NAME___.xcodeproj"

property PBXFileReferences : ""
property PBXGroups : ""

set scriptingEnabled to enableGUIScripting(true)

if scriptingEnabled then
	
	set theProject to choose folder with prompt "Choose Solar2D project folder to import" default location sampleCodePath
	set projectPath to (the POSIX path of theProject)
	
	tell application "Finder"
		
		set projectPathParent to (do shell script "dirname " & quoted form of POSIX path of projectPath)
		set AppleScript's text item delimiters to "/"
		set projectName to text item -2 of projectPath
		
		if exists projectPathParent & "/" & projectName & ".xcodeproj" as POSIX file then
			
			tell application "Xcode" to open (projectPathParent & "/" & projectName & ".xcodeproj")
			
		else if exists projectPath & "main.lua" as POSIX file then
			
			do shell script "cp -pR \"" & templatePath & "\" \"" & projectPathParent & "\";"
			do shell script "cd " & (quoted form of projectPathParent) & "; mv ___CFX_PROJECT_NAME___.xcodeproj " & (quoted form of (projectName & ".xcodeproj"))
			set pbxprojFile to projectPathParent & "/" & projectName & ".xcodeproj/" & "project.pbxproj"
			do shell script "sed -i '' -e 's/___CFX_PROJECT_NAME___/" & projectName & "/g' " & (quoted form of POSIX path of pbxprojFile)
			
			
			-- Add files and folder to project
			set PBXFileReferences to ""
			set PBXGroups to ""
			
			set the_files to (list folder theProject without invisibles)
			repeat with _file in the_files
				set filePath to projectPath & _file
				set fileType to (do shell script "file -b " & filePath)
		
				if fileType ends with "directory" then
					my addFileToProject(_file, true)
				else
					my addFileToProject(_file, false)
				end if
			end repeat
			
			do shell script "sed -i '' -e 's/___PBX_GROUPS___/" & PBXGroups & "/g' " & (quoted form of POSIX path of pbxprojFile)
			do shell script "sed -i '' -e 's/___PBX_FILE_REFERENCES___/" & PBXFileReferences & "/g' " & (quoted form of POSIX path of pbxprojFile)
			
			set schemePath to projectPathParent & "/" & projectName & ".xcodeproj/xcshareddata/xcschemes/"
			do shell script "cd " & (quoted form of schemePath) & "; mv ___CFX_PROJECT_NAME___.xcscheme " & quoted form of (projectName & ".xcscheme")
			do shell script "sed -i '' -e 's/___CFX_PROJECT_NAME___/" & projectName & "/g' " & (quoted form of POSIX path of (schemePath & projectName & ".xcscheme"))
			
			tell application "Xcode" to activate
			delay 1
			tell application "Xcode" to open (projectPathParent & "/" & projectName & ".xcodeproj")
		else
			display alert "Cannot open selected folder" message "The selected folder doesn't seem to be a Solar2D project folder. You should select a folder that contains a main.lua file."
		end if
	end tell
	
end if

on addFileToProject(_name, _isDirectory)
	if _name starts with "Icon-" then
	else
		set uuid to create_uuid()
		set PBXGroups to PBXGroups & uuid & ", "
		
		if _isDirectory then
			set PBXFileReferences to PBXFileReferences & uuid & " = \\{isa = PBXFileReference\\; lastKnownFileType = folder\\; path = \"" & _name & "\"; sourceTree = \"\\<group\\>\"\\; \\}\\; "
		else
			set PBXFileReferences to PBXFileReferences & uuid & " = \\{isa = PBXFileReference\\; path = \"" & _name & "\"\\; sourceTree = \"\\<group\\>\"\\; \\}\\; "
		end if
	end if
end addFileToProject

on replace_chars(this_text, search_string, replacement_string)
	set AppleScript's text item delimiters to the search_string
	set the item_list to every text item of this_text
	set AppleScript's text item delimiters to the replacement_string
	set this_text to the item_list as string
	set AppleScript's text item delimiters to ""
	return this_text
end replace_chars

on create_uuid()
	do shell script "uuidgen"
	set uuid to (get result)
	set uuid to replace_chars(uuid, "-", "")
	set uuid to text 1 thru 24 of uuid
end create_uuid

-- GUI scripting
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

