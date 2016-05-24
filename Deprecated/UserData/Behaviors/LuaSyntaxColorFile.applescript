#!/usr/bin/osascript

-- Xcode behavior script. Choose Lua syntax coloring for selected file.
-- Only works if you already added Lua syntax coloring to Xcode.

tell application "Xcode" to activate

tell application "System Events"
	tell process "Xcode"
		click menu item "Lua" of menu 1 of menu item "Syntax Coloring" of menu 1 of menu bar item "Editor" of menu bar 1
	end tell
end tell

--tell application "Xcode" to activate
