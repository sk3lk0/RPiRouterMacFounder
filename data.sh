#!/bin/bash
echo "START ETHERNET ADAPTER"
sudo ifconfig eth0 192.168.0.1 netmask 255.255.255.0 up
echo "START DHCP SERVER"
sudo service isc-dhcp-server start
echo "REMOVE ARP TABLE"
sudo ip -s -s neigh flush all >> /dev/null
echo "INSERT CABLE"
for ((;;))
do
	arp=$(arp -a | grep "ether] on eth0")
	if [[ -z "$arp" ]]; then
		continue;
	else
		break;
	fi
sleep 5
done
echo "FOUND ARP RECORD"
arp="${arp#* at }" #remove trash
arp="${arp%% *}" #remove trash
echo "${arp#* }"
