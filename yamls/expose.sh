#!/bin/bash

kubectl expose deployment nginx 
	--port=80 \
	--target-port=80 \
	--name=example-service \
	--type=LoadBalancer
