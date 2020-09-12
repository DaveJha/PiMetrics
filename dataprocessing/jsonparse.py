import json

exportdata = {}
exportdata['tags'] = {}
exportdata['fields'] = {}


with open('/opt/wifimetrics/tempdata/unparsedpinger.json') as json_file:
    importdata = json.load(json_file)
    keys = []
    for key in importdata.keys():
        keys.append(key)

    for value in importdata.values():
        exportdata['fields'].update(value)

    exportdata['tags'].update({
        "host":keys[0],
        "test":"pinger"
    })

    exportdata['fields'].pop('destination')

    with open('/opt/wifimetrics/results/resultspinger.json', 'w') as json_file:
        json.dump(exportdata, json_file)
