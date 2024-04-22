#!/bin/sh

kubectl get secrets -o json | jq '.items[] | {name: .metadata.name,data: .data|map_values(@base64d)}' -n kube-system
