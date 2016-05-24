#!/usr/bin/osascript

(*
Xcode behaviour script to install apk files to Android device via adb.
Installation of Android SDK needed. Change buildFolder and adbPath properties
to match your setup.
*)

property buildFolder : (the POSIX path of (path to desktop folder as text)) -- & "/builds"
property adbPath : (the POSIX path of ("HD:Android:sdk:platform-tools"))

--display dialog ("Path to adb: " & adbPath)

set apk to choose file with prompt "Choose .apk to install to device:" of type {"apk"} default location buildFolder
set apkPath to (the POSIX path of apk)

try
	set response to do shell script "cd " & adbPath & "; ./adb install " & apkPath
	if response contains "ALREADY_EXISTS" then
		set button to (display dialog "Do you want to replace existing file on the device?" with icon 2)
		if button = {button returned:"OK"} then
			set response to do shell script "cd " & adbPath & "; ./adb install -r " & apkPath
			complete(response, apkPath)
		end if
	else
		complete(response, apkPath)
	end if
	
on error errorDescription
	display dialog {errorDescription} as text buttons {"OK"}
end try

on complete(response, apkPath)
	if response contains "Success" then
		display dialog "Successfully installed: " & apkPath buttons {"OK"}
	else
		display dialog response buttons {"OK"}
	end if
end complete

