#!/usr/bin/osascript
(*
Xcode behavior script for searching Corona SDK API documentation with Dash.
Searches selected text in Xcode. This script requires the Dash documentation browsing application: http://kapeli.com/dash

*)

activate application "Xcode"
tell application "Xcode" to activate

tell application "System Events"
	set saveClipboard to the clipboard as text
	
	tell process "Xcode"
		click menu item "Copy" of menu 1 of menu bar item "Edit" of menu bar 1
	end tell
	
	delay 0.2
	set lookUp to the clipboard as text
	
	if saveClipboard = lookUp then
		set lookUp to ""
	end if
	
	delay 0.2
	set the clipboard to saveClipboard
end tell

open location "dash://corona: " & lookUp





