#!/bin/sh

echo "SCRIPT CALLED: $0 $*"
echo "JENKNIS VERSION: $1"
echo "PLUGIN FILE: $2"
echo "PLUGIN FILE CONTENTS:"

cat $2
