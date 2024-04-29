#!/bin/bash

#echo enable custom ca trust
#az aks nodepool update \
#	--resource-group rad-aks-rg \
#	--cluster-name aks-rad-django-dev \
#	--name nodepool2 \
#	--enable-custom-ca-trust

echo upload certs
az aks update \
	--resource-group rad-aks-rg \
	--name aks-rad-django-dev \
	--custom-ca-trust-certificates /gm/mincerts.crt
