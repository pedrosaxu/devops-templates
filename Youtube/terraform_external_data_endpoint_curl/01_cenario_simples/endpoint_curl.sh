#!/bin/bash

set -e 

RESULT=$(curl --silent https://type.fit/api/quotes | jq -r '.[] | .text' | shuf -n 1)

jq -n --arg result "$RESULT" '{"result":$result}'

