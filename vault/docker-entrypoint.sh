#!/bin/sh


export LOCAL_IPV4="$(ip addr show eth0 | \
    grep "inet\b" | \
    awk '{print $2}' | \
    cut -d/ -f1)"
# Node ID will just be the Local IPv4 address of the Docker Container
# where periods are replaced with hypens
# e.g 192.168.0.4/20 => 192-168-0-4
export NODE_ID="$(echo "${LOCAL_IPV4}" | sed 's/\./-/g')"

# Starting Unseal Process And Detaching It So We Can Start Vault
init.sh &

# Generating Vault Config
envsubst < /vault/config/vault.hcl.template > /vault/config/vault.hcl

# It is recommended that the Raft data be purged from a Node
# before it joins the Raft cluster. Therefore it is a relatively safe
# operation to consistently nuke this directory (even on first time startup)
rm -rf /vault/file/*

# Start Vault Cluster
docker-entrypoint.sh "$@"
