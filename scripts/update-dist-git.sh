#!/bin/sh

echo "SCRIPT CALLED: $0 $*"
echo "JENKNIS VERSION: $1"
echo "OCP RELEASE: $2"
echo "HPIs DIR: $3"
echo "HPIs DIR CONTENT: $3"

ls -laF $3
