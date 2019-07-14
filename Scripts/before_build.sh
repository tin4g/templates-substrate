#!/bin/bash
set -e

PROJECT_PATH=`echo "$(cd "$(dirname "$0")/.."; pwd)"`

if [ -f "$PROJECT_PATH/Package.swift" ]; then cd "$PROJECT_PATH/"; else trap 'echo "Project not found."' EXIT; exit 1; fi
if ! [ -x "$(command -v carthage)" ]; then brew install carthage; fi
if ! [ -x "$(command -v xcpretty)" ]; then gem install xcpretty; fi

swift package generate-xcodeproj --xcconfig-overrides "$PROJECT_PATH/Configuration/@@PROJECTNAME@@.xcconfig"
