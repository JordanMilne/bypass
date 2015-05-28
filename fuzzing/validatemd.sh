#!/bin/bash
echo "** ${1}"
./build/bypass-validator < $1
