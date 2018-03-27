#!/bin/bash

sudo ./launch_lxc.sh -n r -t vpp-ext_quic -l 1
sudo ./launch_lxc.sh -n s -t vpp-ext_quic -l 1

#Connecting to the container 
sleep 20
sudo lxc-attach -n r -- vpp unix { log /tmp/vpp.log full-coredump startup-config /scratch/example/quic_proto/r.conf cli-listen localhost:5002 }
sleep 30
sudo lxc-attach -n s -- vpp unix { log /tmp/vpp.log full-coredump startup-config /scratch/example/quic_proto/s.conf cli-listen localhost:5002 }


