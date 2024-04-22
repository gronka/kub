#!/bin/sh

encoded=""

cat <<< $encoded
echo ...

#decoded=$(echo "$encoded" | base64 --decode)
decoded=$(base64 --decode <<< $encoded)

cat <<< $decoded
