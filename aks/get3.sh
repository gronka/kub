#!/bin/bash

az aks get-credentials --resource-group rad-aks-rg --name djangoappcluster --file config-django.yaml
