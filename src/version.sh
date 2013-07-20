#!/bin/bash

VER_MAJOR=0
MINOR_VER=1
BUILD_NUM=1

DESCRIPTION="Water pump controller"

TAG=`git tag | tail -1`
COMMIT=`git rev-parse HEAD`
BRANCH=`git rev-parse --abbrev-ref HEAD`

if [ "$TAG" != "" ]; then
	VER_MAJOR=`echo $TAG | sed 's/\./ /g' | awk '{print $1}'`
	VER_MINOR=`echo $TAG | sed 's/\./ /g' | awk '{print $2}'`
	BUILD_NUM=`git log --pretty=format:'' | wc -l`
fi

AUTHOR="Andrian Yablonskyy"
EMAIL="andrian.yablonskyy@gmail.com"
SKYPE="andrian.yablonsky"
CELL="+(380) 67 439 - 18 - 81"
COPYRIGHT=`echo "Copyright (c) 2013, $AUTHOR. All rights reserved."`

HEADER=$(echo "/*
 *
 * $COPYRIGHT
 *
 * Contact info:
 *    $AUTHOR
 *    E-mail: $EMAIL
 *    Skype: $SKYPE
 *    Cell phone: $CELL
 *
 */
 
/*
 * Do not change this file.
 * It is auto-generated and will be replaced on the next build.
 */
 
")

echo "$HEADER" > $1
echo "#ifndef __PUMP_VERSION_H__" >> $1
echo "#define __PUMP_VERSION_H__" >> $1
echo "" >> $1
echo "/* Version info */" >> $1
echo "#define VER_MAJOR $VER_MAJOR" >> $1
echo "#define VER_MINOR $VER_MINOR" >> $1
echo "#define BUILD_NUM $BUILD_NUM" >> $1
echo "" >> $1
echo "/* Source info */" >> $1
echo "#define SRC_BRANCH \"$BRANCH\"" >> $1
echo "#define SRC_COMMIT \"$COMMIT\"" >> $1
echo "" >> $1
echo "#define COPYRIGHT \"$COPYRIGHT\"" >> $1
echo "" >> $1
echo "#define AUTHOR_NAME \"$AUTHOR\"" >> $1
echo "#define AUTHOR_EMAIL \"$EMAIL\"" >> $1
echo "#define AUTHOR_SKYPE \"$SKYPE\"" >> $1
echo "#define AUTHOR_PHONE \"$CELL\"" >> $1
echo "" >> $1
echo "#define DESCRIPTION \"$DESCRIPTION\"" >> $1
echo "" >> $1
echo "#define VERSION \"$VER_MAJOR.$VER_MINOR-$BUILD_NUM\"" >> $1
echo "" >> $1
echo "#endif /* __PUMP_VERSION_H__*/" >> $1
echo "" >> $1

