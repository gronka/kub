#!/bin/bash

sudo docker login
cd /gm/tethys

# sudo docker buildx build -t gronka/tethys:latest --progress=plain --no-cache .

sudo docker buildx build -t gronka/tethys:latest --progress=plain .

sudo docker push gronka/tethys:latest
