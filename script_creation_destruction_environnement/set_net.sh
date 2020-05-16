#!/bin/bash

echo " --********* Bridge creation *********-- "
echo 

ovs-vsctl add-br br0

echo 
echo "Creation done !"
echo 

ip link set dev br0 up
ip link set dev ovs-system up 

echo" bridge activation done ..." 

echo 
echo " --********* state of the bridge *********-- "
echo 

ovs-vsctl show 

echo