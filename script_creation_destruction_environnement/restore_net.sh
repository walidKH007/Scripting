#!/bin/bash

echo " --********* destruction of the bridge *********-- "
echo

ip link set dev br0 down
ip link set dev ovs-system down

echo
echo " bridges disabled ... "
echo

ovs-vsctl del-br br0 

echo
echo "Delete Bridge Done ..." 
echo

echo
echo "----- state of bridge ----- "
echo

ovs-vsctl show


