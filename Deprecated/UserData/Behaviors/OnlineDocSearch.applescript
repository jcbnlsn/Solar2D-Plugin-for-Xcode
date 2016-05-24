#!/usr/bin/osascript
(*
Xcode behavior script for searching online Corona SDK API documentation.
Searches selected text in Xcode. Uses safari browser. Only works with library and type calls and properties. ( not events )
*)

-- globals
set globalsList to {"assert", "collectgarbage", "error", "getfenv", "getmetatable", "ipairs", "next", "pairs", "pcall", "print", "rawequal", "rawget", "rawset", "select", "setfenv", "setmetatable", "tonumber", "tostring", "type", "unpack"}
set packageList to {"module", "require"}

-- types
set typeNames to {"Body", "ButtonWidget", "CoronaLibrary", "CoronaPrototype", "DisplayObject", "EventListener", "File", "GroupObject", "InputAxis", "Joint", "LineObject", "Map", "PhysicsContact", "PickerWidget", "ProgressViewWidget", "Recording", "Runtime", "ScrollViewWidget", "SegmentedControlWidget", "SliderWidget", "SnapshotObject", "ShapeObject", "SpriteObject", "StageObject", "StepperWidget", "SwitchWidget", "TabBarWidget", "TableViewWidget", "TextBox", "TextField", "TextObject", "Video", "WebView"}
set TypeList to {{"angularDamping", "angularVelocity", "applyAngularImpulse", "applyForce", "applyLinearImpulse", "applyTorque", "bodyType", "getLinearVelocity", "gravityScale", "isAwake", "isBodyActive", "isBullet", "isFixedRotation", "isSensor", "isSleepingAllowed", "linearDamping", "mass", "resetMassData", "setLinearVelocity"}, {"getLabel", "setEnabled", "setLabel"}, {"getCurrentProvider", "name", "publisherId", "revision", "setCurrentProvider", "version"}, {"initialize", "instanceOf", "isClass", "isRoot", "new", "newClass", "setExtension"}, {"alpha", "anchorX", "anchorY", "contentBounds", "contentHeight", "contentToLocal", "contentWidth", "height", "isHitTestMasked", "isHitTestable", "isVisible", "localToContent", "maskRotation", "maskScaleX", "maskScaleY", "maskX", "maskY", "parent", "removeSelf", "rotate", "rotation", "scale", "setMask", "setReferencePoint", "toBack", "toFront", "translate", "width", "x", "xScale", "y", "yScale"}, {"addEventListener", "dispatchEvent", "removeEventListener"}, {"close", "flush", "lines", "read", "seek", "setvbuf", "write"}, {"insert", "numChildren", "remove"}, {"accuracy", "descriptor", "maxValue", "minValue", "number", "type"}, {"dampingRatio", "frequency", "getAnchorA", "getAnchorB", "getGroundAnchorA", "getGroundAnchorB", "getLimits", "getAnchorA", "getAnchorA", "getAnchorA", "getReactionForce", "getRotationLimits", "getTarget", "isLimitEnabled", "isCollideConnected", "isLimitEnabled", "isMotorEnabled", "joint1", "joint2", "jointAngle", "jointSpeed", "jointTranslation", "length", "length1", "length2", "limitState", "maxForce", "maxLength", "maxMotorForce", "maxMotorTorque", "maxTorque", "motorForce", "motorSpeed", "motorTorque", "ratio", "reactionTorque", "jointAngle", "removeSelf", "setLimits", "setRotationLimits", "setTarget", "springDampingRatio", "springFrequency"}, {"anchorSegments", "append", "setColor"}, {"addMarker", "getAddressLocation", "getUserLocation", "isLocationVisible", "isScrollEnabled", "isZoomEnabled", "mapType", "nearestAddress", "removeAllMarkers", "removeMarker", "requestLocation", "setCenter", "setRegion"}, {"bounce", "friction", "isEnabled", "isTouching"}, {"getValues"}, {"getProgress", "resizeView", "setProgress"}, {"getSampleRate", "getTunerFrequency", "getTunerVolume", "isRecording", "setSampleRate", "startRecording", "startTuner", "stopRecording", "stopTuner"}, {"hasEventSource", "hideErrorAlerts"}, {"getContentPosition", "scrollTo", "scrollToPosition", "setIsLocked", "setScrollHeight", "setScrollWidth", "takeFocus"}, {"segmentLabel", "segmentNumber"}, {"blendMode", "fill", "path", "setFillColor", "setStrokeColor", "stroke", "strokeWidth"}, {"setValue", "value"}, {"canvas", "canvasMode", "clearColor", "group", "invalidate", "textureFilter", "textureWrapX", "textureWrapY"}, {"frame", "isPlaying", "numFrames", "pause", "play", "sequence", "setFrame", "setSequence", "timeScale"}, {"setFocus"}, {"getValue", "maximumValue", "minimumValue", "value"}, {"isOn", "setState"}, {"setSelected"}, {"deleteAllRows", "deleteRow", "getContentPosition", "getNumRows", "getRowAtIndex", "insertRow", "reloadData", "scrollToIndex", "scrollToY", "setIsLocked"}, {"align", "font", "hasBackground", "isEditable", "placeholder", "setReturnKey", "setTextColor", "size", "text"}, {"align", "font", "hasBackground", "inputType", "isSecure", "placeholder", "setReturnKey", "setTextColor", "size", "text"}, {"setEmbossColor", "setTextColor", "size", "text"}, {"currentTime", "isMuted", "load", "pause", "play", "seek", "totalTime"}, {"back", "canGoBack", "canGoForward", "forward", "hasBackground", "reload", "request", "stop"}}

set searchType to "library"

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

--display dialog (lookUp)
set AppleScript's text item delimiters to {"."}
try
	set testValue to text item 2 of lookUp
on error
	set AppleScript's text item delimiters to {":"}
end try
set docType to text item 1 of lookUp

if globalsList contains docType then
	set docElement to docType
	set docType to "global"
else if packageList contains docType then
	set docElement to docType
	set docType to "package"
else
	try
		set docElement to text item 2 of lookUp
		set listIndex to 0
		repeat with currentTypeList in TypeList as list
			set listIndex to (listIndex + 1)
			if currentTypeList contains docElement then
				set docType to (item listIndex of typeNames)
				set searchType to "type"
				exit repeat
			end if
		end repeat
	on error
		set inTypeList to false
		set listIndex to 0
		repeat with currentTypeList in TypeList as list
			set listIndex to (listIndex + 1)
			if currentTypeList contains docType then
				set docElement to docType
				set docType to (item listIndex of typeNames)
				set searchType to "type"
				set inTypeList to true
				exit repeat
			end if
		end repeat
		
		if inTypeList = false then
			set docElement to "index"
			set searchType to "library"
		end if
	end try
end if

set docType to trimAndCut(docType)
set docElement to trimAndCut(docElement)

if docElement = "" then docElement = "index"

set docUrl to "http://docs.coronalabs.com/api/" & searchType & "/" & docType & "/" & docElement & ".html"

tell application "Safari" to activate
tell application "Safari"
	try
		set windowName to name of front document as string
		if windowName = "Untitled" then
			delay 0.5
		end if
	on error
		make new document
	end try
	set the URL of the front document to docUrl
end tell


on trimAndCut(someText)
	repeat until someText does not start with " "
		set someText to text 2 thru -1 of someText
	end repeat
	
	repeat until someText does not end with " "
		set someText to text 1 thru -2 of someText
	end repeat
	
	set AppleScript's text item delimiters to {"("}
	try
		set someText to text item 1 of someText
	end try
	
	set AppleScript's text item delimiters to {"."}
	try
		set someText to text item 1 of someText
	end try
	
	return someText
end trimAndCut

set foundDoc to true
(*
delay 1.5
tell application "Safari"
	set windowName to name of front document as string
	if windowName = "404 Not Found" then
		set the URL of the front document to "http://docs.coronalabs.com/api/index.html"
		set foundDoc to false
	end if
end tell

if foundDoc = false then
	delay 1.5
	tell application "System Events"
		tell process "Safari"
			click menu item "Find…" of menu 1 of menu item "Find" of menu 1 of menu bar item "Edit" of menu bar 1
		end tell
	end tell
end if
*)




