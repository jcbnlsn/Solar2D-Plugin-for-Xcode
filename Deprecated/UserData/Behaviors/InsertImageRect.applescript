#!/usr/bin/osascript

tell application "Xcode"
	
	tell front project
		set targetProject to (get project directory)
		set projectName to (get name)
		set pbxFile to targetProject & "/" & projectName & ".xcodeproj/project.pbxproj"
		
		set projectPath to targetProject & "/" & projectName
		--display dialog projectPath
	end tell
end tell

set image to choose file with prompt "Choose image to import:" of type {"png", "jpg"} default location projectPath
set imagePath to (the POSIX path of image)

set AppleScript's text item delimiters to {projectPath}
set relativeImagePath to "#" & text item 2 of imagePath

tell application "Image Events"
	launch
	set theImg to open alias imagePath
	set imgInfo to properties of theImg
	copy (name of imgInfo) to fullImgName
	copy (dimensions of imgInfo) to {x, y}
	
	close theImg
end tell

set AppleScript's text item delimiters to {"."}
set imgName to text item 1 of fullImgName

set AppleScript's text item delimiters to {"#/"}
set relativeImagePath to text item 2 of relativeImagePath

--display dialog "dimensions " & x & " " & y & " - name " & imgName

set code to "local " & imgName & " = display.newImageRect ( g, '" & relativeImagePath & "', " & x & ", " & y & ") " & "
" & imgName & ".anchorX, " & imgName & ".anchorY = 0.5, 0.5" & "
" & imgName & ".x, " & imgName & ".y = 0,0"
set the clipboard to code

tell application "Xcode" to activate
tell application "System Events"
	keystroke "v" using {command down}
end tell


