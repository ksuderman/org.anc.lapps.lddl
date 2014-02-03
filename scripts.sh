#!/bin/bash

# Zips the example script files in the modules and scripts directories.

set -eu

RES=src/test/resources
SCRIPTS=$RES/scripts
MODULES=$RES/modules
ZIPFILE=lddl-scripts.zip
MODZIP=lddl-modules.zip

if [ ! -e $SCRIPTS ] ; then
	echo "Scripts directory not found: $SCRIPTS"
	exit
fi

if [ ! -e $MODULES ] ; then
	echo "Modules directory not found: $MODULES"
	exit
fi

cd $RES
if [ -e $ZIPFILE ] ; then
	echo "Removing existing file: $ZIPFILE"
	rm $ZIPFILE
fi

if [ -e $MODZIP ] ; then
	echo "Removing existing file: $MODZIP"
	rm $MODZIP
fi

echo "Packaging scripts."
zip $ZIPFILE scripts/*.*

echo "Packaging modules."
zip $MODZIP modules/*.*

if [ -e /Volumes/share ] ; then
	cp $ZIPFILE /Volumes/share
	cp $MODZIP /Volumes/share
	echo "Copied zip files to share"
fi
