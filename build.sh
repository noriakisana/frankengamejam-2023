#!/usr/bin/env bash

set -e

rm -rf dist/
mkdir -p dist

echo 'Building for web ...'
godot --headless --no-window --export-release "Web" dist/index.html
cp enable-threads.js dist/
echo 'done.'

echo 'Building for linux ...'
godot --headless --no-window --export-release 'Linux/X11' dist/giventake.x86_64
chmod a+x dist/giventake.x86_64
echo 'done.'

echo 'Building for Windows ...'
godot --headless --no-window --export-release 'Windows Desktop' dist/giventake.exe
echo 'done.'

