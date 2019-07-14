#!/bin/bash
set -e

PROJECT_PATH=`echo "$(cd "$(dirname "$0")/.."; pwd)"`
PLATFORM_NAME="iOS"

if [ -f "$PROJECT_PATH/Package.swift" ]; then cd "$PROJECT_PATH/"; else trap 'echo "Project not found."' EXIT; exit 1; fi
if [ -d "$INSTALL_PATH" ]; then rsync -raz "$PROJECT_PATH"/Dependencies/$PLATFORM_NAME/*.framework "$INSTALL_PATH/"; else trap 'echo "INSTALL_PATH not found"' EXIT; exit 1; fi

for framework in $(find "$INSTALL_PATH/" -name *.framework); do ldid -S "$framework/$(basename "$framework" .framework)"; done
