#!/bin/bash

function abort()
{
	echo "Aborting!"
	exit
}

function sure()
{
	read -r -p "Are you sure you want to continue? [y/N] " response
	response=${response,,}    # tolower
	if [[ ! $response =~ ^(yes|y)$ ]]; then
		abort
	fi
}

DIR=$(readlink -f  "$(dirname "${BASH_SOURCE[0]}" )")
HM=$(readlink -f "$DIR/../home/")


echo "\
#######################################################
#        The Life Tectonic XSEDE setup script         #
#######################################################

READ CAREFULLY!

This script will setup your environment like one that
The Life Tectonic scripts and utilities expects for an
XSEDE system.

This may destroy a signfiicant portion of customizations
made to your environment.  You should carefully consider
if this is what you want to do before proceding. 

If you have any doubts the look in:
${HM}

The contents of this directory will be copied to your 
\$HOME directory:
$HOME

"

sure

. $HM/lib/sh/tlt-functions

detect_system
if [ ! -n "$XSEDE_SYSTEM" ]; then
	echo "Unknown XSDED system `hostname`"
	abort
fi

echo "Setup detected XSEDE system \"${XSEDE_SYSTEM}\"
if this is incorrect please abort.
"
sure

