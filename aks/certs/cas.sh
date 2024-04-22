#!/bin/bash

az aks update \
	--resource-group rad-aks-rg \
	--name aks-rad-django-dev \
	--custom-ca-trust-certificates ca-bundle-rde.crt
