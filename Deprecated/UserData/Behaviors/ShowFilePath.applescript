#!/usr/bin/osascript

-- Xcode behaviour script to reveal selected file in finder

tell application "Xcode"
	activate
	set my_document to path of text document 1
end tell

tell application "Finder"
	reveal my_document as POSIX file
	activate
end tell
