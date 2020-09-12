#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
from influxdb import InfluxDBClient
from pprint import pprint


exportdata = []

f = open("/opt/wifimetrics/sensorname", "r")
name = f.read()

def collectData(strpath):
    with open(strpath) as json_file:
        importdata = json.load(json_file)
        importdata.update( {"measurement":"pimetric"} )
        importdata.update( {"tags":{"sensorname":name}} )
        exportdata.append(importdata)

collectData('/opt/wifimetrics/results/resultsdns.json')
collectData('/opt/wifimetrics/results/resultshttp.json')
collectData('/opt/wifimetrics/results/resultsiperf.json')
collectData('/opt/wifimetrics/results/resultspinger.json')
collectData('/opt/wifimetrics/results/resultswifi.json')

f.close()
pprint(exportdata)
## Put in details of Influx client here
client = InfluxDBClient(host='PUT HOST HERE', port=, username='', password='', database='network')
print(client.write_points(exportdata))
