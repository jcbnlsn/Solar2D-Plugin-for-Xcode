#!/bin/bash

# -----------------------------------------------------------------------------------
#
# Uninstall Solar2D Plugin for Xcode
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

# -----------------------------------------------------------------------------------
# Delete Corona entries in DVTFoundation.xcplugindata
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.SourceCodeLanguage.Corona'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona2'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona3'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona4'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona5'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona6'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona7'
$PLISTBUDDY "$DVTFOUNDATION_PATH/DVTFoundation.xcplugindata"  -c 'Delete plug-in:extensions:Xcode.FileDataType.Corona8'

# Remove the xclangspec for the Corona language
rm "$DVTFOUNDATION_PATH/Corona.xclangspec"

# Remove the xclangspec and metadata for the Corona language - Xcode 11+
rm "$SOURCEMODEL_PATH/LanguageSpecifications/Corona.xclangspec"
rm "$SOURCEMODEL_PATH/LanguageMetadata/Xcode.SourceCodeLanguage.Corona.plist"

# -----------------------------------------------------------------------------------
# Delete auto-completion files
rm -rf "$USERDATA_PATH/UserData/CodeSnippets/"*".cfx.codesnippet"

# -----------------------------------------------------------------------------------
# Delete templates scripts
rm -rf "$USERDATA_PATH/Templates/Solar2D";
rm -rf "$USERDATA_PATH/Templates/CFXTemplate";

# -----------------------------------------------------------------------------------
# Remove Behavior Scripts and KeyBindings
rm -rf "$USERDATA_PATH/UserData/KeyBindings/Solar2D.idekeybindings";
rm -rf "$USERDATA_PATH/UserData/KeyBindings/CoronaSDK.idekeybindings";
rm -rf "$USERDATA_PATH/UserData/Behaviors/"*".cfx.applescript"

# Find Solar2D behavior entries in Xcode.CustomAlertEvents
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

# Delete Solar2D behavior entries
for ((i=${#DELETE_ENTRIES[@]}-1; i>=0; i--)); do
    echo  "delete ${DELETE_ENTRIES["$i"]}"
    $PLISTBUDDY "$PREFERENCES_PATH/com.apple.dt.Xcode.plist" -c 'Delete Xcode.CustomAlertEvents:'${DELETE_ENTRIES["$i"]}
done

# Remove any cached Xcode plugins
# Xcode 6+
rm -f /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache-Debug.xcplugincache
# Xcode 4,5
rm -f /private/var/folders/*/*/*/com.apple.DeveloperTools/*/Xcode/PlugInCache.xcplugincache

echo  "-------------------------------------------------"
echo  "Completed un-installing Solar2D Plugin for Xcode."
echo  "-------------------------------------------------"

