#!/bin/bash

set -e

eval "$(jq -r '@sh "token=\(.token)"')"

TOKEN="$token"

curl --silent 'https://app.terraform.io/api/v2/organizations/pedrosaxu/projects' --header 'Authorization: Bearer '$TOKEN'' | jq '.data | map({key: .attributes.name, value: .id}) | from_entries'