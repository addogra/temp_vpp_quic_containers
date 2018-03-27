#!/bin/bash

sudo ./launch_lxc.sh -n r -t vpp-ext_quic -l 1
sudo ./launch_lxc.sh -n s -t vpp-ext_quic -l 1

#Connecting to the container 
sudo lxc-attach -n r -- vpp unix { log /tmp/vpp.log full-coredump startup-config /scratch/example/quic-proto/r.conf cli-listen localhost:5002 }
sudo lxc-attach -n s -- vpp unix { log /tmp/vpp.log full-coredump startup-config /scratch/example/quic-proto/s.conf cli-listen localhost:5002 }


