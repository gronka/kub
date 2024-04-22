#!/bin/sh

key="
"
echo $key
echo ...

encoded=$(echo "$key" | base64)

echo $encoded
echo ...

#decoded=$(echo "$encoded" | base64 --decode)
decoded=$(base64 --decode <<< $encoded)

cat <<< $decoded

