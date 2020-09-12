# WiFi Metrics
Dave Jha (drj222@lehigh.edu)

The purpose of this project is to run a series of metrics on a network and report the findings via InfluxDB.

## Tests

The following are the current tests being utilized to measure a network:

### DNS

This test uses the DNS Lookup Utility (dig) to preform a lookup on the specified URL. It runs dns.sh within the bin directory, outputs the resulting json to resultsdns.json in the results directory. 

This test reports the following metrics:

#### Fields
1. Average Time - the time in seconds it takes to run a DNS lookup 

#### Tags
1. URL - The URL in which the test is being conducted against
2. Test - The name of the test (dnstest)

### HTTP

This test uses the HTTPie (a HTTP utility) to preform a http request on the specified URL. It runs http.sh within the bin directory, outputs the resulting json to resultshttp.json in the results directory. 

This test reports the following metrics:

#### Fields
1. Average Time - the time in seconds it takes to run a GET request on the URL

#### Tags
1. URL - The URL in which the test is being conducted against
2. Test - The name of the test (httptest)

### Iperf

This test uses the iperf test to conduct active measurements of the maximum achievable bandwidth on IP networks. It runs iperf.sh within the bin directory, which runs iperf.py in the dataprocessing directory, and outputs the resulting json to resultsiperf.json in the results directory. 

This test reports the following metrics:

#### Fields
1. Average Time - the average time in seconds it takes all the test to be conducted against each stream
2. Average Received Rate - the average rate in mb/s taken to receive data through each stream, rounded to the hundreth place.
3. Average Sent Rate -  the average rate in mb/s taken to send data through each stream, rounded to the hundreth place.

#### Tags
1. connectedhost - The URL in which the test is being conducted against
2. localhost - The IP address of the machine the script is being run on 
3. protocol - The protocol (TCP, UDP, SCTP) being used on the test
4. test - The name of the test (iperf)

### Ping

This test uses pingparsing (built off of ping) to check the connectivity status between a source and a destination over the network. It runs pingparsing.sh within the bin directory, which runs jsonparse.py in the dataprocessing directory, and outputs the resulting json to resultspinger.json in the results directory. 

This test reports the following metrics:

#### Fields
1. packet_duplicate_rate: the rate of packets that were duplicated against the total
2. packet_receive: the amount of packets received during transmission
3. rtt_min: the minimum time it took for the data to go round trip 
4. rtt_avg: the average time it took for the data to go round trip 
5. rtt_max: the maximum time it took for the data to go round trip 
6. rtt_mdev: an average of how far each ping RTT is from the mean RTT 
7. packet_loss_count: the amount of packets lost during transmission
8. packet_loss_rate: the rate of packets lost during transmission against the total
9. packet_duplicate_count: the amount of packets duplicated because of a failure
10. packet_transmit: the amount of packet sent during transmission


#### Tags
1. Host - The URL in which the test is being conducted against
2. Test - The name of the test (pinger)

### WiFi

This test uses iwlist to scan for available wireless networks and display additional information. It runs wifi.sh within the bin directory, which runs wifiparse.pl in the dataprocessing directory, and outputs the resulting json to resultwifi.json in the results directory. 

This test reports the following metrics:

#### Fields
1. freq - frequency in GHz of the radio spectrum. 
2. quality - may be based on the level of contention or interference, the bit or frame error rate, how good the received signal is, some timing synchronisation, or other hardware metric
3. signal - received signal strength (RSSI – how strong the received signal is) based off the driver's meta information
4. mac - The MAC address of the device

#### Tags
1. ESSID - The name of the wifi network the device is connected to
2. Test - The name of the test (wifiparse)

## collectdata.py
Congregates all the JSON files, formats, and sends to the influxdb

 
## Runtime
 
 Currently, wifimetrics.cron houses the commands that are responsible for measuring the metrics on a specific time interval (defaultly set to every five minutes). 
 
 To add a metric:
 1. Add the necessary bash script to bin directory
 2. Ensure the script outputs to a JSON file within results directory
 3. Add a line in collectdata.py within dataprocessing directory to read in the JSON file
 
 To remove a metric:
 1. Remove the executable command within the wifimetrics.cron
 
 To modify the URL being tested against:
 1. Set the specified URL against each test within wifimetrics.cron


