#/bin/#!/bin/sh
echo "Fix for:" $3
mv "$2/Launcher.exe" "$2/Launcher.exe.backup"
mv "$2/aomx.exe" "$2/Launcher.exe"
echo "Fix complete!"
