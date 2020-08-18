#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Install Solar2D Plugin for Xcode
# Copyright © 2016-2020 Jacob Nielsen. All rights reserved.
#
# -----------------------------------------------------------------------------------

# Paths
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"
PLISTBUDDY=/usr/libexec/PlistBuddy
DVTFOUNDATION_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/DVTFoundation.framework/Resources/"
SOURCEMODEL_PATH="/Applications/Xcode.app/Contents/SharedFrameworks/SourceModel.framework/Resources/"
XCODE_APPLICATIONS_PATH="/Applications/Xcode.app/Contents/Applications/"
USERDATA_PATH="$HOME/Library/Developer/Xcode"
PREFERENCES_PATH="$HOME/Library/Preferences/"

# Create folders if they don't exist
mkdir -p "$USERDATA_PATH/UserData"
mkdir -p "$USERDATA_PATH/Templates"
mkdir -p "$USERDATA_PATH/UserData/KeyBindings"
mkdir -p "$USERDATA_PATH/UserData/CodeSnippets"
mkdir -p "$USERDATA_PATH/UserData/Behaviors"

# -----------------------------------------------------------------------------------
# Modify Xcode to support Corona syntax highlighting

# Delete previous Solar2D entries in DVTFoundation.xcplugindata
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.SourceCodeLanguage.Corona'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona2'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona3'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona4'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona5'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona6'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona7'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona8'

# Create Plist language entry to add to 'DVTFoundation.xcplugindata'
cat >Language.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Xcode.FileDataType.Corona</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>com.apple.xcode.corona-source</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona2</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>com.barebones.bbedit.lua-source</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona3</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>org.lua.lua-source</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona4</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>public.lua-script</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona5</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>de.codingmonkeys.subethaedit.lua-source</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona6</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>public.lua-source</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona7</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>com.apple.xcode.lua-source</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.FileDataType.Corona8</key>
    <dict>
        <key>id</key>
        <string>Xcode.FileDataType.Corona</string>
        <key>localizedDescription</key>
        <string>Solar2D Source</string>
        <key>name</key>
        <string>File type for Solar2D</string>
        <key>point</key>
        <string>Xcode.FileDataType</string>
        <key>typeConformedTo</key>
        <array>
            <dict>
                <key>typeIdentifier</key>
                <string>public.plain-text</string>
            </dict>
        </array>
        <key>typeIdentifier</key>
        <string>org.tug.lua</string>
        <key>version</key>
        <string>1.0</string>
    </dict>
    <key>Xcode.SourceCodeLanguage.Corona</key>
    <dict>
        <key>languageSpecification</key>
        <string>xcode.lang.corona</string>
        <key>fileDataType</key>
        <array>
            <dict>
                <key>identifier</key>
                <string>com.apple.xcode.corona-source</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>com.barebones.bbedit.lua-source</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>org.lua.lua-source</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>public.lua-source</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>public.lua-script</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>de.codingmonkeys.subethaedit.lua-source</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>com.apple.xcode.lua-source</string>
            </dict>
            <dict>
                <key>identifier</key>
                <string>org.tug.lua</string>
            </dict>
        </array>
        <key>id</key>
        <string>Xcode.SourceCodeLanguage.Corona</string>
        <key>point</key>
        <string>Xcode.SourceCodeLanguage</string>
        <key>languageName</key>
        <string>Solar2D Lua</string>
        <key>version</key>
        <string>1.0</string>
        <key>conformsTo</key>
        <array>
            <dict>
                <key>identifier</key>
                <string>Xcode.SourceCodeLanguage.Generic</string>
            </dict>
        </array>
        <key>name</key>
        <string>Solar 2D Lua</string>
    </dict>
</dict>
</plist>
EOF

# Merge language into DVTFoundation.xcplugindata
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Merge Language.plist plug-in:extensions'

# Remove temporary Language.plist
rm -f Language.plist

# Copy in the xclangspecs for the Solar2D language
cp -p "$SCRIPT_PATH/PluginData/SyntaxHighlight/Corona.xclangspec" "$DVTFOUNDATION_PATH"

# Copy in the xclangspecs for Solar2D language - Xcode 11+
cp -p "$SCRIPT_PATH/PluginData/SyntaxHighlight/Corona.xclangspec" "$SOURCEMODEL_PATH/LanguageSpecifications/"

# Copy in the language metadata for Solar2D language - Xcode 11+
cp -p "$SCRIPT_PATH/PluginData/SyntaxHighlight/Xcode.SourceCodeLanguage.Corona.plist" "$SOURCEMODEL_PATH/LanguageMetadata/"

# -----------------------------------------------------------------------------------
# Copy auto-completion files
cp -pR "$SCRIPT_PATH/PluginData/UserData/CodeSnippets" "$USERDATA_PATH/UserData/";

# -----------------------------------------------------------------------------------
# Copy templates scripts
cp -pR "$SCRIPT_PATH/PluginData/Templates" "$USERDATA_PATH/";

# -----------------------------------------------------------------------------------
# Behaviors

# Find corona behavior entries in Xcode.CustomAlertEvents
PREFERENCES_PATH="$HOME/Library/Preferences/"
goon=1
c=0
e=0
while [ $goon -eq 1 ]
do
    EXISTS="$(echo | $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist" -c 'Print Xcode.CustomAlertEvents:'$c':alerts')";
    if [ "$EXISTS" == "" ]; then
        goon=0
    else
        ENTRY="$(echo | $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist" -c 'Print Xcode.CustomAlertEvents:'$c':alerts:Xcode.Alert.RunScript:path')";
        if [[ $ENTRY == *".cfx.applescript"* ]]
        then
            DELETE_ENTRIES["$e"]=$c
            (( e++ ))
        fi
    fi
    (( c++ ))
done

# Delete corona behavior entries if any
for ((i=${#DELETE_ENTRIES[@]}-1; i>=0; i--)); do
    $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist" -c 'Delete Xcode.CustomAlertEvents:'${DELETE_ENTRIES["$i"]}
done

# Create Plist file with behavior entries
cat >Behaviors.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
	<dict>
		<key>title</key>
		<string>Solar2D Import Project</string>
		<key>alerts</key>
		<dict>
			<key>Xcode.Alert.ShowUtilityArea</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowToolbar</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.FirstIssue</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>destination</key>
				<string>firstIssue</string>
			</dict>
			<key>Xcode.Alert.Dialog</key>
			<dict>
				<key>enabled</key>
				<true/>
			</dict>
			<key>Xcode.Alert.ShowEditor</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowTab</key>
			<dict>
				<key>lastChanged</key>
				<real>0</real>
				<key>enabled</key>
				<false/>
				<key>tabName</key>
				<string></string>
				<key>tabTarget</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.Speech</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>voice</key>
				<string>com.apple.speech.synthesis.voice.Alex</string>
			</dict>
			<key>Xcode.Alert.RunScript</key>
			<dict>
				<key>enabled</key>
				<true/>
				<key>path</key>
				<string>BEHAVIOR_PATH/import-project.cfx.applescript</string>
			</dict>
			<key>Xcode.Alert.ShowNavigator</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>navigator</key>
				<string>Xcode.IDEKit.Navigator.Structure</string>
			</dict>
			<key>Xcode.Alert.ShowDebugger</key>
			<dict>
				<key>visibility</key>
				<integer>0</integer>
				<key>destination</key>
				<string>workspace</string>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<string>show</string>
			</dict>
			<key>Xcode.Alert.Sound</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>soundPath</key>
				<string>/System/Library/Sounds/Sosumi.aiff</string>
			</dict>
			<key>Xcode.Alert.Bounce</key>
			<dict>
				<key>enabled</key>
				<false/>
			</dict>
		</dict>
		<key>identifier</key>
		<string>EB4E5F34-23C3-4DC1-1B4B-B65CF0070EB1-101-010108A6C9FCF62A</string>
	</dict>
	<dict>
		<key>title</key>
		<string>Solar2D API Lookup</string>
		<key>alerts</key>
		<dict>
			<key>Xcode.Alert.ShowUtilityArea</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowToolbar</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.FirstIssue</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>destination</key>
				<string>firstIssue</string>
			</dict>
			<key>Xcode.Alert.Dialog</key>
			<dict>
				<key>enabled</key>
				<true/>
			</dict>
			<key>Xcode.Alert.ShowEditor</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowTab</key>
			<dict>
				<key>lastChanged</key>
				<real>0</real>
				<key>enabled</key>
				<false/>
				<key>tabName</key>
				<string></string>
				<key>tabTarget</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.Speech</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>voice</key>
				<string>com.apple.speech.synthesis.voice.Alex</string>
			</dict>
			<key>Xcode.Alert.RunScript</key>
			<dict>
				<key>enabled</key>
				<true/>
				<key>path</key>
				<string>BEHAVIOR_PATH/doc-lookup.cfx.applescript</string>
			</dict>
			<key>Xcode.Alert.ShowNavigator</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>navigator</key>
				<string>Xcode.IDEKit.Navigator.Structure</string>
			</dict>
			<key>Xcode.Alert.ShowDebugger</key>
			<dict>
				<key>visibility</key>
				<integer>0</integer>
				<key>destination</key>
				<string>workspace</string>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<string>show</string>
			</dict>
			<key>Xcode.Alert.Sound</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>soundPath</key>
				<string>/System/Library/Sounds/Sosumi.aiff</string>
			</dict>
			<key>Xcode.Alert.Bounce</key>
			<dict>
				<key>enabled</key>
				<false/>
			</dict>
		</dict>
		<key>identifier</key>
		<string>FA2E2F53-85D7-4DA2-9C6B-A23CF9060FF1-505-000009A6A9FCE65A</string>
	</dict>
	<dict>
		<key>title</key>
		<string>Solar2D Show Project Files</string>
		<key>alerts</key>
		<dict>
			<key>Xcode.Alert.ShowUtilityArea</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowToolbar</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.FirstIssue</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>destination</key>
				<string>firstIssue</string>
			</dict>
			<key>Xcode.Alert.Dialog</key>
			<dict>
				<key>enabled</key>
				<true/>
			</dict>
			<key>Xcode.Alert.ShowEditor</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowTab</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>lastChanged</key>
				<real>0</real>
				<key>tabTarget</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.Speech</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>voice</key>
				<string>com.apple.speech.synthesis.voice.Alex</string>
			</dict>
			<key>Xcode.Alert.RunScript</key>
			<dict>
				<key>enabled</key>
				<true/>
				<key>path</key>
				<string>BEHAVIOR_PATH/import-project.cfx.applescript</string>
			</dict>
			<key>Xcode.Alert.ShowNavigator</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>navigator</key>
				<string>Xcode.IDEKit.Navigator.Structure</string>
			</dict>
			<key>Xcode.Alert.ShowDebugger</key>
			<dict>
				<key>visibility</key>
				<integer>0</integer>
				<key>destination</key>
				<string>workspace</string>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<string>show</string>
			</dict>
			<key>Xcode.Alert.Sound</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>soundPath</key>
				<string>/System/Library/Sounds/Sosumi.aiff</string>
			</dict>
			<key>Xcode.Alert.Bounce</key>
			<dict>
				<key>enabled</key>
				<false/>
			</dict>
		</dict>
		<key>identifier</key>
		<string>45723B41-A14F-3288-97B4-13F8A43F0EED-505-000119B4062C0510</string>
	</dict>
	<dict>
		<key>title</key>
		<string>Solar2D Show Project Sandbox</string>
		<key>alerts</key>
		<dict>
			<key>Xcode.Alert.ShowUtilityArea</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowToolbar</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.FirstIssue</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>destination</key>
				<string>firstIssue</string>
			</dict>
			<key>Xcode.Alert.Dialog</key>
			<dict>
				<key>enabled</key>
				<true/>
			</dict>
			<key>Xcode.Alert.ShowEditor</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowTab</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>lastChanged</key>
				<real>0</real>
				<key>tabTarget</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.Speech</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>voice</key>
				<string>com.apple.speech.synthesis.voice.Alex</string>
			</dict>
			<key>Xcode.Alert.RunScript</key>
			<dict>
				<key>enabled</key>
				<true/>
				<key>path</key>
				<string>BEHAVIOR_PATH/show-project-sandbox.cfx.applescript</string>
			</dict>
			<key>Xcode.Alert.ShowNavigator</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<integer>0</integer>
				<key>navigator</key>
				<string>Xcode.IDEKit.Navigator.Structure</string>
			</dict>
			<key>Xcode.Alert.ShowDebugger</key>
			<dict>
				<key>visibility</key>
				<integer>0</integer>
				<key>destination</key>
				<string>workspace</string>
				<key>enabled</key>
				<false/>
				<key>action</key>
				<string>show</string>
			</dict>
			<key>Xcode.Alert.Sound</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>soundPath</key>
				<string>/System/Library/Sounds/Sosumi.aiff</string>
			</dict>
			<key>Xcode.Alert.Bounce</key>
			<dict>
				<key>enabled</key>
				<false/>
			</dict>
		</dict>
		<key>identifier</key>
		<string>E6A387DF-70EC-434B-BE17-820966636837-505-000009BE41529961</string>
	</dict>
	<dict>
		<key>alerts</key>
		<dict>
			<key>Xcode.Alert.Bounce</key>
			<dict>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.Dialog</key>
			<dict>
				<key>enabled</key>
				<true/>
			</dict>
			<key>Xcode.Alert.FirstIssue</key>
			<dict>
				<key>destination</key>
				<string>firstIssue</string>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.RunScript</key>
			<dict>
				<key>enabled</key>
				<true/>
				<key>path</key>
				<string>/Users/jcb/Library/Developer/Xcode/UserData/Behaviors/adb-install.cfx.applescript</string>
			</dict>
			<key>Xcode.Alert.ShowDebugger</key>
			<dict>
				<key>action</key>
				<string>show</string>
				<key>destination</key>
				<string>workspace</string>
				<key>enabled</key>
				<false/>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowEditor</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowNavigator</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
				<key>navigator</key>
				<string>Xcode.IDEKit.Navigator.Structure</string>
			</dict>
			<key>Xcode.Alert.ShowTab</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>tabTarget</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowToolbar</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.ShowUtilityArea</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.Sound</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>soundPath</key>
				<string>/System/Library/Sounds/Sosumi.aiff</string>
			</dict>
			<key>Xcode.Alert.Speech</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>voice</key>
				<string>com.apple.speech.synthesis.voice.Alex</string>
			</dict>
		</dict>
		<key>identifier</key>
		<string>00B18E88-5BAE-4934-9F01-8FF554BB5C5A-696-00010A09CB96C508</string>
		<key>title</key>
		<string>Android Install</string>
	</dict>
	<dict>
		<key>alerts</key>
		<dict>
			<key>Xcode.Alert.Bounce</key>
			<dict>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.Dialog</key>
			<dict>
				<key>enabled</key>
				<true/>
			</dict>
			<key>Xcode.Alert.FirstIssue</key>
			<dict>
				<key>destination</key>
				<string>firstIssue</string>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.RunScript</key>
			<dict>
				<key>enabled</key>
				<true/>
				<key>path</key>
				<string>/Users/jcb/Library/Developer/Xcode/UserData/Behaviors/adb-start-logcat.cfx.applescript</string>
			</dict>
			<key>Xcode.Alert.ShowDebugger</key>
			<dict>
				<key>action</key>
				<string>show</string>
				<key>destination</key>
				<string>workspace</string>
				<key>enabled</key>
				<false/>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowEditor</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
				<key>visibility</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowNavigator</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
				<key>navigator</key>
				<string>Xcode.IDEKit.Navigator.Structure</string>
			</dict>
			<key>Xcode.Alert.ShowTab</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>tabTarget</key>
				<integer>0</integer>
			</dict>
			<key>Xcode.Alert.ShowToolbar</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.ShowUtilityArea</key>
			<dict>
				<key>action</key>
				<integer>0</integer>
				<key>enabled</key>
				<false/>
			</dict>
			<key>Xcode.Alert.Sound</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>soundPath</key>
				<string>/System/Library/Sounds/Sosumi.aiff</string>
			</dict>
			<key>Xcode.Alert.Speech</key>
			<dict>
				<key>enabled</key>
				<false/>
				<key>voice</key>
				<string>com.apple.speech.synthesis.voice.Alex</string>
			</dict>
		</dict>
		<key>identifier</key>
		<string>4603C301-1752-45A8-AEE3-2A60BB10CDFF-696-00012FA50A0E5AC9</string>
		<key>title</key>
		<string>Android Start Logcat</string>
	</dict>
</array>
</plist>
EOF

# Set bahavior paths
BEHAVIOR_PATH="$HOME/Library/Developer/Xcode/UserData/Behaviors"

$PLISTBUDDY "Behaviors.plist" -c "Set 0:alerts:Xcode.Alert.RunScript:path $BEHAVIOR_PATH/import-project.cfx.applescript"
$PLISTBUDDY "Behaviors.plist" -c "Set 1:alerts:Xcode.Alert.RunScript:path $BEHAVIOR_PATH/doc-lookup.cfx.applescript"
$PLISTBUDDY "Behaviors.plist" -c "Set 2:alerts:Xcode.Alert.RunScript:path $BEHAVIOR_PATH/show-project-files.cfx.applescript"
$PLISTBUDDY "Behaviors.plist" -c "Set 3:alerts:Xcode.Alert.RunScript:path $BEHAVIOR_PATH/show-project-sandbox.cfx.applescript"
$PLISTBUDDY "Behaviors.plist" -c "Set 4:alerts:Xcode.Alert.RunScript:path $BEHAVIOR_PATH/adb-install.cfx.applescript"
$PLISTBUDDY "Behaviors.plist" -c "Set 5:alerts:Xcode.Alert.RunScript:path $BEHAVIOR_PATH/adb-start-logcat.cfx.applescript"

# Check if Xcode.CustomAlertEvents entry exists or create it
EXISTS="$(echo | $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Print Xcode.CustomAlertEvents')";

if [[ $EXISTS == "" ]]
then
    $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Add :Xcode.CustomAlertEvents array'
fi

# Merge in the behaviors
$PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Merge Behaviors.plist Xcode.CustomAlertEvents'

# Get rid of the Behaviors.plist
rm -f Behaviors.plist

# Copy Behavior scripts folder
cp -pR "$SCRIPT_PATH/PluginData/UserData/Behaviors" "$USERDATA_PATH/UserData/";

# Copy Keybindings scripts folder
cp -pR "$SCRIPT_PATH/PluginData/UserData/KeyBindings" "$USERDATA_PATH/UserData/";

# Check if IDEKeyBindingCurrentPreferenceSet entry exists or create it
EXISTS="$(echo | $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Print IDEKeyBindingCurrentPreferenceSet')";

if [[ $EXISTS == "" ]]
then
    $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Add :IDEKeyBindingCurrentPreferenceSet string'
fi

# Set Solar2DSDK.keybinding as current
$PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Set IDEKeyBindingCurrentPreferenceSet Solar2D.idekeybindings'

# Check if DVTTextShowLineNumbers entry exists or create it
EXISTS="$(echo | $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Print DVTTextShowLineNumbers')";

if [[ $EXISTS == "" ]]
then
    $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Add :DVTTextShowLineNumbers bool'
fi

# Set show line numbers to true
$PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Set DVTTextShowLineNumbers true'

# Check if DVTTextUsesSyntaxAwareIndenting entry exists or create it
EXISTS="$(echo | $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Print DVTTextUsesSyntaxAwareIndenting')";

if [[ $EXISTS == "" ]]
then
    $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Add :DVTTextUsesSyntaxAwareIndenting bool'
fi

# Set syntax aware indenting to false
$PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist"  -c 'Set DVTTextUsesSyntaxAwareIndenting false'

# Remove any cached Xcode plugins
# Xcode 6+
rm -f /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache-Debug.xcplugincache
# Xcode 4,5
rm -f /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache.xcplugincache

pkill -x 'Solar2D for Xcode'

echo  "------------------------------------------------"
echo  "Completed installing Solar2D Plugin for Xcode."
echo  "You can start using Xcode now."
echo  "------------------------------------------------"











