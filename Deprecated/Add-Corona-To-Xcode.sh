#!/bin/bash

# Run this script to add Corona support to Xcode
# Created by Jacob Nielsen 2014

# Path where this script is located
SCRIPT_PATH="$(dirname "$BASH_SOURCE")"

# Path to Xcode user library
XCODE_PATH="$HOME/Library/Developer/Xcode/"

# Copy files
cp -R "$SCRIPT_PATH/Templates" "$XCODE_PATH"
cp -R "$SCRIPT_PATH/UserData" "$XCODE_PATH/"

# Add Lua syntax coloring
cd "$SCRIPT_PATH/SyntaxColoring"
source Add-Lua.sh



