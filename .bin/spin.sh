#!/bin/bash

if [[ -z "$1" ]]
then
    echo "gimme a branch-name punk"
else
    curl -s -X POST -H "content-type: application/json" \
        --data '{"mix": "app", "data": "'$1'", "duration": 21600}' \
        http://spinner.10.10.10.39.xip.io/api/sessions \
        | grep 'id' \
        | cut -d'"' -f4 \
        | { read test; echo http://$test.spinner.10.10.10.39.xip.io/; } \
        | pbcopy

    echo "copied instance URL to clipboard..."
    exit 1
fi
