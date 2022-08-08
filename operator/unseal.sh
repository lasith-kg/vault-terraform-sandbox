#!/bin/sh -l
set -euo pipefail

if [ -z ${VAULT_CAPATH+x} ]; then echo "FATAL: 🔴 envvar VAULT_CAPATH must be set"; exit 1; fi
if [ -z ${VAULT_CLIENT_CERT+x} ]; then echo "FATAL: 🔴 envvar VAULT_CLIENT_CERT must be set"; exit 1; fi
if [ -z ${VAULT_CLIENT_KEY+x} ]; then echo "FATAL: 🔴 envvar VAULT_CLIENT_KEY must be set"; exit 1; fi

# Check if Vault Node is already unsealed
if [[ "$(curl -s -o /dev/null -w '%{http_code}' -k https://vault:8200/v1/sys/health)" == "200" ]]; then
    echo "INFO: Vault Node is Already Unsealed"
    exit 0
fi

# Waiting for Vault server to start (Skip TLS Verify -k)
while [[ "$(curl -s -o /dev/null -w '%{http_code}' -k https://vault:8200/v1/sys/health)" != "501" ]]; do sleep 1; echo -n '.'; done

vault_init=$(vault operator init -key-shares=5 -key-threshold=3 -format=json)
vault_root_token=$(echo $vault_init | jq -r '.root_token')

# Unseal Vault using Previously Generated Key Shares
for unseal_token in $(echo "$vault_init" | jq -r '.unseal_keys_b64[]'); do vault operator unseal "$unseal_token" > /dev/null ; done

# Persist Root Vault Token into ~/.profile
echo "export VAULT_TOKEN=$vault_root_token" >> ~/.profile

echo "INFO: Root Vault Token: ${vault_root_token:0:7}***"