#!/bin/bash

MAJOR_VER=0.0
MINOR_VER=1



echo "const char gPumpVersion[] = \"$MAJOR_VER.$MINOR_VER\";" > $1version.c
