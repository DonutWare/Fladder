#!/bin/bash

# Script to create DMG for Fladder macOS app using create-dmg
# Usage: ./create_dmg.sh

set -e

# Configuration
APP_NAME="Fladder"
APP_PATH="build/macos/Build/Products/Release-production/Fladder.app"
DMG_PATH="build/macos/Build/Products/Release-production/macOS.dmg"
BACKGROUND_IMAGE="assets/macos-dmg/Fladder-DMG-Background.jpg"
TEMP_DMG_DIR="dmg_temp"

# Check if app exists
if [ ! -d "$APP_PATH" ]; then
    echo "Error: App not found at $APP_PATH"
    echo "Please build the app first with: flutter build macos --flavor production"
    exit 1
fi

# Check if background image exists
if [ ! -f "$BACKGROUND_IMAGE" ]; then
    echo "Error: Background image not found at $BACKGROUND_IMAGE"
    exit 1
fi

# Clean up any existing artifacts
rm -rf "$TEMP_DMG_DIR"
rm -f "$DMG_PATH"

echo "Creating DMG for $APP_NAME with custom background..."

# Create temporary directory structure for DMG
mkdir -p "$TEMP_DMG_DIR"
cp -R "$APP_PATH" "$TEMP_DMG_DIR/"

# Create DMG with create-dmg using enhanced settings
create-dmg \
    --volname "$APP_NAME" \
    --volicon "$APP_PATH/Contents/Resources/AppIcon.icns" \
    --background "$BACKGROUND_IMAGE" \
    --window-pos 200 120 \
    --window-size 800 500 \
    --icon-size 80 \
    --icon "$APP_NAME.app" 200 250 \
    --hide-extension "$APP_NAME.app" \
    --app-drop-link 600 250 \
    --format UDZO \
    --hdiutil-quiet \
    "$DMG_PATH" \
    "$TEMP_DMG_DIR"

# Clean up temp directory
rm -rf "$TEMP_DMG_DIR"

echo "DMG created successfully at: $DMG_PATH"

# Verify the DMG was created
if [ -f "$DMG_PATH" ]; then
    echo "DMG file size: $(du -h "$DMG_PATH" | cut -f1)"
    echo "You can test the DMG by opening: $DMG_PATH"
else
    echo "ERROR: DMG creation failed!"
    exit 1
fi
