#!/bin/sh
set -euo pipefail

export LOCAL_IPV4="$(ip addr show eth0 | \
    grep "inet\b" | \
    awk '{print $2}' | \
    cut -d/ -f1)"

# Node ID will just be a shortened Container ID hash
#   e.g bbd84e75e92f
export NODE_ID="$(hostname)"

# Starting Unseal Process And Detaching It So We Can Start Vault
initialise.sh &

# Generating Vault Config
envsubst < /vault/config/vault.hcl.template > /vault/config/vault.hcl

# It is recommended that the Raft data be purged from a Node
# before it joins the Raft cluster. Therefore it is a relatively safe
# operation to consistently nuke this directory (even on first time startup)
rm -rf /vault/file/*

# Start Vault Cluster
docker-entrypoint.sh "$@"
