#!/bin/sh -l
set -euo pipefail

node_type="${1:-}"

if [ "${node_type}" != "leader" ] && [ "${node_type}" != "follower" ]; then
    cat << EOF >&2
ERROR: Must provide a valid argument to get-node.sh
Current Value:  ${1:-}
Expected Values: [leader, follower]
EOF
    exit 1
fi

set +e
if [ "${node_type}" = "leader" ]; then
    container_id="$(vault operator raft list-peers -format=json | jq -er '.data.config.servers | map(select(.leader)) | first | .node_id')"
else
    container_id="$(vault operator raft list-peers -format=json | jq -er '.data.config.servers | map(select(.leader|not)) | first | .node_id')"
fi
status="$?"
set -e

if [ "${status}" != "0" ]; then
    echo "ERROR: Could not identify a node of type ${node_type}" >&2
    exit 1
else
    echo "${container_id}"
fi
