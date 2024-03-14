#!/bin/bash

filename=../images/debian$1.qcow2

if [ -f $filename ]; then
	echo file $filename already exists
else
	qemu-img create -f qcow2 $filename 30G
fi
