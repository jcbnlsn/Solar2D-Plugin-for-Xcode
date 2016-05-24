#!/usr/bin/osascript

-- Xcode behavior script. Lua syntax color current project.

tell application "Xcode"
	
	tell first project
		set targetProject to (get project directory)
		set projectName to (get name)
		set pbxFile to targetProject & "/" & projectName & ".xcodeproj/project.pbxproj"
	end tell
end tell

do shell script "perl -pi -w -e 's/lastKnownFileType = sourcecode.lua;/lastKnownFileType = sourcecode.corona; xcLanguageSpecificationIdentifier = xcode.lang.lua;/g' " & (quoted form of the POSIX path of pbxFile)