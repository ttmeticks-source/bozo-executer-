#!/bin/bash
# build.sh
APP_DIR="/Applications/BozoExecuter.app"
ARCH=$(uname -m)

echo "Building for architecture: $ARCH"

rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS"
mkdir -p "$APP_DIR/Contents/Resources"

# Compile Dylib
clang -arch $ARCH -dynamiclib -O3 src/dylib.m -o "$APP_DIR/Contents/Resources/libBozo.dylib"

# Compile App
clang -arch $ARCH -framework Cocoa -O3 src/main.m -o "$APP_DIR/Contents/MacOS/BozoExecuter" -ldl
chmod +x "$APP_DIR/Contents/MacOS/BozoExecuter"

# Create Info.plist
cat << 'EOF' > "$APP_DIR/Contents/Info.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleExecutable</key>
    <string>BozoExecuter</string>
    <key>CFBundleIdentifier</key>
    <string>com.bozo.executer</string>
    <key>CFBundleName</key>
    <string>Bozo Executer</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>NSHighResolutionCapable</key>
    <true/>
</dict>
</plist>
EOF

# Move bridge.lua
cp src/bridge.lua "$APP_DIR/Contents/Resources/bridge.lua"

# Sign
codesign --force --deep --sign - "$APP_DIR"
echo "Build complete. App is in $APP_DIR"
