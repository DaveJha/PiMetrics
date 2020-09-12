import json
from decimal import *
from pprint import pprint

TWOPLACES = Decimal(10) ** -2
exportdata = {}
exportdata['fields'] = {}
exportdata['tags'] = {}

with open('/opt/wifimetrics/tempdata/unparsediperf.json') as json_file:
    importdata = json.load(json_file)
    connectedHost = importdata["start"]["connecting_to"]["host"]
    protocol = importdata["start"]["test_start"]["protocol"]
    localhost = importdata["start"]["connected"][0]["local_host"]

    exportdata['tags'].update({
        'connectedhost':connectedHost,
        'protocol':protocol,
        'localhost':localhost,
        'test':'iperf'
    })

    time = importdata["end"]["streams"][0]["sender"]["seconds"]
    avgsentrate = float(str(Decimal(importdata["end"]["sum_sent"]["bits_per_second"] / 12500000).quantize(TWOPLACES)))
    retransmits = importdata["end"]["sum_sent"]["retransmits"]
    avgreceivedrate = float(str(Decimal(importdata["end"]["sum_received"]["bits_per_second"] / 12500000).quantize(TWOPLACES)))


    exportdata['fields'].update({
        'avgtime':time,
        'avgsentrate':avgsentrate,
        'avgreceivedrate':avgreceivedrate
    })

    with open('/opt/wifimetrics/results/resultsiperf.json', 'w') as json_file:
        json.dump(exportdata, json_file)
