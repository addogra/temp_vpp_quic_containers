#!/bin/bash

#Disable the Virtual Address Randomizer first
echo 0 | sudo tee /proc/sys/kernel/randomize_va_space

sudo ./launch_lxc.sh -n r -t vpp-ext_quic -l 2
sudo ./launch_lxc.sh -n s -t vpp-ext_quic -l 2
sudo ./connect_lxc.sh -c ./example/quic_proto/config.txt -f ./example/quic_proto/connect.log
#Connecting to the container 
sleep 10
sudo lxc-attach -n r -- vpp unix { log /tmp/vpp.log full-coredump startup-config /scratch/example/quic_proto/r.conf cli-listen localhost:5002 } tls { ca-cert-path /scratch/example/quic_proto/server.crt }
sleep 10
lxc-attach -n s -- ip address add 192.168.0.20/24 dev l_s1
lxc-attach -n s -- ip route add default via 192.168.0.1


