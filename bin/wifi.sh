#!/bin/bash

/sbin/iwlist wlan0 scan > /opt/wifimetrics/tempdata/wifi
/usr/bin/perl /opt/wifimetrics/dataprocessing/wifiparse.pl

