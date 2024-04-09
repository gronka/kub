#!/bin/bash

kubectl exec -n tethys --stdin --tty $1 -- /bin/bash
