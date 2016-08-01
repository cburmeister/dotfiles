#!/bin/bash
#
# eventcommand.sh - Handle events supplied via pianobar.
#

while read L; do
    k="`echo "$L" | cut -d '=' -f 1`"
    v="`echo "$L" | cut -d '=' -f 2`"
    export "$k=$v"
done < <(grep -e '^\(title\|artist\|album\|coverArt\)=' /dev/stdin)

case "$1" in
    songstart)
        terminal-notifier \
            -title "$title" \
            -contentImage $coverArt \
            -group pianobar \
            -message "$artist on $album" \
            -appIcon "http://goo.gl/JBWwHu" \
            -open "goo.gl/XscXfg: $artist $title $album" \
            > /dev/null 2>&1
        ;;
esac
