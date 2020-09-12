#!/bin/bash
export TIMEFORMAT='%3R'
URL=${1?Error: no url given}

exec 4>&2
TIME=$( { time dig "$URL" +stats +noall 1>/dev/null 2>&4; } 2>&1 )

JSON_FMT='{"fields":{"avgtime":%f},"tags":{"url":"%s","test":"dnstest"}}\n'
printf "$JSON_FMT" $TIME "$URL" > /opt/wifimetrics/results/resultsdns.json

exec 4>&-
