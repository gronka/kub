#!/bin/bash

kubectl debug node/aks-nodepool1-42776210-vmss000000 -it --image=mcr.microsoft.com/cbl-mariner/busybox:2.0
