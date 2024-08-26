#!/bin/bash
# clear the limit
sudo tc qdisc del dev enp0s31f6 root
sudo tc qdisc del dev wlp1s0 root
# Add a root qdisc (queue discipline) with Hierarchical Token Bucket (HTB)
sudo tc qdisc add dev enp0s31f6 root handle 1: htb default 12

# Create a class for download limit
sudo tc class add dev enp0s31f6 parent 1: classid 1:1 htb rate 512kbit ceil 512kbit

# Create a class for upload limit
sudo tc class add dev enp0s31f6 parent 1: classid 1:2 htb rate 512kbit ceil 512kbit

# Add filters to match all traffic to the download and upload classes
sudo tc filter add dev enp0s31f6 protocol ip parent 1:0 prio 1 u32 match ip src 0.0.0.0/0 flowid 1:1
sudo tc filter add dev enp0s31f6 protocol ip parent 1:0 prio 1 u32 match ip dst 0.0.0.0/0 flowid 1:2

#///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
# Add a root qdisc (queue discipline) with Hierarchical Token Bucket (HTB)
sudo tc qdisc add dev wlp1s0 root handle 1: htb default 12

# Create a class for download limit
sudo tc class add dev wlp1s0 parent 1: classid 1:1 htb rate 512kbit ceil 512kbit

# Create a class for upload limit
sudo tc class add dev wlp1s0 parent 1: classid 1:2 htb rate 512kbit ceil 512kbit

# Add filters to match all traffic to the download and upload classes
sudo tc filter add dev wlp1s0 protocol ip parent 1:0 prio 1 u32 match ip src 0.0.0.0/0 flowid 1:1
sudo tc filter add dev wlp1s0 protocol ip parent 1:0 prio 1 u32 match ip dst 0.0.0.0/0 flowid 1:2

