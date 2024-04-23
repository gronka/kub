#!/bin/bash

kubectl get endpointslices -l kubernetes.io/service-name=tethys-ers-ce-lb -n tethys
