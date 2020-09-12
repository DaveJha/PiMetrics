#!/bin/bash

URL=${1?Error: no url given}

/usr/local/bin/pingparsing "$URL" > /opt/wifimetrics/tempdata/unparsedpinger.json
/usr/bin/python3 /opt/wifimetrics/dataprocessing/jsonparse.py
