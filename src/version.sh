#!/bin/bash

VER_MAJOR=0
MINOR_VER=1
BUILD_NUM=1

TAG=`git describe --abbrev=64 | sed 's/.*g//g'`
COMMIT=`git rev-parse HEAD`
BRANCH=`git rev-parse --abbrev-ref HEAD`

if [ "$TAG" != "" ]; then
	VER_MAJOR=`echo $TAG | sed 's/\./ /g' | awk '{print $1}'`
	VER_MINOR=`echo $TAG | sed 's/\./ /g' | awk '{print $2}' | sed 's/-/ /g' | awk '{print $1}'`
	BUILD_NUM=`echo $TAG | sed 's/-/ /g' | awk '{print $2}'`
fi

echo "/***************************************************************************** " > $1
echo " *                                                                             " >> $1
echo " * Copyright (c) 2013, Andrian Yablonskyy. All rights reserved.                " >> $1
echo " *                                                                             " >> $1
echo " * Contact info:                                                               " >> $1
echo " *    Andrian Yablonskyy                                                       " >> $1
echo " *    E-mail: andrian.yablonskyy@gmail.com                                     " >> $1
echo " *    Skype: andrian.yablonskyy                                                " >> $1
echo " *    Cell phone: +(380) 67 439 - 18 - 81                                      " >> $1
echo " *                                                                             " >> $1
echo " *****************************************************************************/" >> $1
echo "" >> $1
echo "" >> $1
echo "/************************************************************** " >> $1
echo " * Do not change this file.                                     " >> $1
echo " * It is auto-generated and will be replaced on the next build. " >> $1
echo " **************************************************************/" >> $1
echo "" >> $1
echo "/* Version info */" >> $1
echo "#define VER_MAJOR $VER_MAJOR" >> $1
echo "#define VER_MIMOR $VER_MINOR" >> $1
echo "#define BUILD_NUM $BUILD_NUM" >> $1
echo "" >> $1
echo "#define SRC_BRANCH \"$BRANCH\"" >> $1
echo "#define CRC_COMMIT \"$COMMIT\"" >> $1
echo "" >> $1
echo "const char g_szFullVersion[] = \"$VER_MAJOR.$VER_MINOR-$BUILD_NUM\";" >> $1
echo "" >> $1

