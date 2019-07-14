#!/bin/bash
set -e

PROJECT_PATH=`echo "$(cd "$(dirname "$0")/.."; pwd)"`

if [ -f "$PROJECT_PATH/Substrate/Makefile" ]; then
	cd "$PROJECT_PATH/Substrate/"

	if [ "$1" = "-c" ]; then
		make clean && make clean-packages
	else
		DEBUG="${DEBUG:-1}" TARGET="${TARGET:-iphone:latest:latest}" ARCHS="${ARCHS:-arm64}" make do
	fi
else
	trap 'echo "Makefile not found."' EXIT
	exit 1
fi
