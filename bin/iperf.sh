#!/bin/bash

URL=${1?Error: no url given}

/usr/bin/iperf3 -c "$URL" -J > /opt/wifimetrics/tempdata/unparsediperf.json
/usr/bin/python3 /opt/wifimetrics/dataprocessing/iperf.py
