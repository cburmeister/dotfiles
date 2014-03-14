#!/bin/bash
#
# manipulate XPlanet (installed via homebrew) to make an
# earth-from-space image suitable for a desktop background.
#
# This script is run periodically via launchd (com.eafarris.xplanet)

# Based on http://pantburk.info/?blog=78

CONFIG=$HOME/Library/Xplanet/config
OUTPUTDIR=$HOME/Pictures/xplanet
CLOUDURL=http://xplanet.sourceforge.net/clouds/clouds_2048.jpg
CLOUDIMAGE=$HOME/Library/Xplanet/clouds.jpg

if [ ! -d "${OUTPUTDIR}" ]; then
    mkdir -p $OUTPUTDIR
fi

# get cloud image
/usr/bin/curl -L $CLOUDURL > $CLOUDIMAGE

# clean out the output directory
rm -f $OUTPUTDIR/*

# make the background
/usr/local/bin/xplanet -config $CONFIG \
    --quality 95 \
    -verbosity 0 \
    --num_times 1 \
    --output $OUTPUTDIR/$RANDOM.jpg \
    --geometry 2560x1440 \
    --projection rectangular
