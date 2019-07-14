#!/bin/bash
set -e

PROJECT_PATH=`echo "$(cd "$(dirname "$0")/.."; pwd)"`
CONFIGURATION=`[[ -z "$DEBUG" || "$DEBUG" -eq "1" ]] && echo "Debug" || echo "Release"`
SDK_ROOT="iphoneos"
PLATFORM_NAME="iOS"

if [ -f "$PROJECT_PATH/Package.swift" ]; then cd "$PROJECT_PATH/"; else trap 'echo "Project not found."' EXIT; exit 1; fi

mkdir -p "$PROJECT_PATH/Dependencies/$PLATFORM_NAME/"
xcodebuild clean && xcodebuild ONLY_ACTIVE_ARCH=NO ARCHS="$ARCHS" -target @@PROJECTNAME@@ -sdk $SDK_ROOT -configuration $CONFIGURATION | xcpretty
rsync -raz "$PROJECT_PATH"/build/$CONFIGURATION-$SDK_ROOT/*.framework "$PROJECT_PATH/Dependencies/$PLATFORM_NAME/"

if [ -f "$PROJECT_PATH/Cartfile" ]; then
	carthage update --platform $PLATFORM_NAME --configuration $CONFIGURATION --cache-builds
	rsync -raz "$PROJECT_PATH"/Carthage/Build/$PLATFORM_NAME/*.framework "$PROJECT_PATH/Dependencies/$PLATFORM_NAME/"
fi
