#!/usr/bin/osascript

-- Xcode behaviour script to open Android Device Monitor
-- Installation of Android SDK needed. Change adm_path below to your own.

property adm_path : "HD:Android:sdk:tools:monitor"

tell application "System Events" to set ddmsIsRunning to (name of processes) contains "ddms"

if ddmsIsRunning = false then
	tell application "Finder" to open adm_path
	delay 1
end if