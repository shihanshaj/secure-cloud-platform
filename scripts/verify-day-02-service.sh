#!/bin/sh
set -eu

base_url=${1:-http://localhost:8080}
body=$(curl --fail --silent --show-error "$base_url/health")
printf 'Health response: %s\n' "$body"
printf '%s' "$body" | python3 -c 'import json,sys; assert json.load(sys.stdin) == {"status": "healthy"}'
status=$(curl --silent --output /dev/null --write-out '%{http_code}' "$base_url/health")
test "$status" = 200
printf 'HTTP status: %s\n' "$status"
api_id=$(docker compose ps -q api)
test -n "$api_id"
ports=$(docker inspect --format '{{json .NetworkSettings.Ports}}' "$api_id")
printf 'API container port bindings: %s\n' "$ports"
printf '%s' "$ports" | python3 -c 'import json,sys; ports=json.load(sys.stdin); assert ports.get("8000/tcp") is None, "API port 8000 must not be published to the host"'
printf '%s\n' 'API port 8000 is not published to the host.'
