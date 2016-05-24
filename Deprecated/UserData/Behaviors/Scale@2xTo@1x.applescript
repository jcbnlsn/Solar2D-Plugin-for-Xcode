#!/usr/bin/osascript

(*
Xcode behaviour script to create @1x.png downscaled copies of @2x.png files.
It brings up a browser to select the files in your Xcode/Corona project folder.
You can select multiple files. The source files must be named with the @2x.png
extension.
*)

property errorOccured : false

to rescale_and_save(this_item)
	tell application "Image Events"
		launch
		
		-- open the image file
		set this_image to open this_item
		
		set imgInfo to properties of this_image
		copy (dimensions of imgInfo) to {x, y}
		
		set the target_width to x / 2
		
		set typ to this_image's file type
		
		copy dimensions of this_image to {current_width, current_height}
		if current_width is greater than current_height then
			scale this_image to size target_width
		else
			-- figure out new height
			-- y2 = (y1 * x2) / x1
			set the new_height to (current_height * target_width) / current_width
			scale this_image to size new_height
		end if
		
		set AppleScript's text item delimiters to {"@2x"}
		set temp_name to (name of this_item)
		set image_name to (text item 1 of temp_name) & (text item 2 of temp_name)
		
		tell application "Finder" to set new_item to Â
			(container of this_item as string) & image_name
		save this_image in new_item as typ
		
	end tell
end rescale_and_save

tell application "Xcode"
	tell first project
		set targetProject to (get project directory)
		set projectName to (get name)
	end tell
	
	set projectPath to targetProject & "/" & projectName
end tell

set image_list to choose file with prompt "Select @2x png's to create @1x copies of:" of type {"png", "jpg"} default location projectPath with multiple selections allowed

repeat with i in image_list
	try
		rescale_and_save(i)
	on error
		
		if errorOccured is false then
			display dialog "An error occured while downscaling!"
		end if
		set errorOccured to true
	end try
end repeat

if errorOccured is false then
	display dialog "" & (length of image_list) & " @2x images scaled to @1x"
end if