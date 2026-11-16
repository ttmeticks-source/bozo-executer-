#!/bin/bash
# install.sh
REPO_URL="https://github.com/yourusername/bozo-executer/archive/refs/heads/main.zip"
TMP_DIR="/tmp/bozo-install"

echo "Downloading Bozo Executer..."
mkdir -p "$TMP_DIR"
curl -sL "$REPO_URL" -o "$TMP_DIR/repo.zip"
unzip -q "$TMP_DIR/repo.zip" -d "$TMP_DIR"

echo "Building..."
cd "$TMP_DIR/bozo-executer-main"
chmod +x build.sh
./build.sh

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "Opening..."
sudo /Applications/BozoExecuter.app/Contents/MacOS/BozoExecuter
