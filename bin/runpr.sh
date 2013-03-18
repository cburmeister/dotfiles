#
# Usage:
# Make sure to chmod +x, then:
# ./runpr 50
# `50` is the pull request number in the github URL

#!/bin/bash
NUMBER=$1
curl -H "Content-Type: application/json" -d "{\"action\": \"synchronize\", \"pull_request\": {\"number\": $NUMBER, \"html_url\": \"https://github.com/discogs/discogs/pull/$NUMBER\", \"base\": {\"repo\": {\"full_name\": \"discogs/discogs\"}}, \"head\": {\"repo\": {\"full_name\": \"discogs/discogs\"}}}}" http://cibox:2021/notification/github
