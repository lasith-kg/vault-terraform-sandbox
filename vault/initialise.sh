#!/bin/sh -l
set -euo pipefail

if [ -z ${VAULT_ADDR+x} ]; then echo "FATAL: 🔴 envvar VAULT_ADDR must be set"; exit 1; fi

main() {
    # Waiting for Vault server to start
    while true; do
        status_code="$(curl -s -o /dev/null -w '%{http_code}' "${VAULT_ADDR}/v1/sys/health" || true)"
        if [ "${status_code}" = "200" ] || [ "${status_code}" = "501" ]; then
            break
        fi
        echo -n "."
        sleep 1
    done

    # If Dev Mode is Active, We Then Avoid Initilising And Create
    # A Transit Engine So That We Can Bootstrap Auto-Unseal Process
    if [ -n "${VAULT_DEV_ROOT_TOKEN_ID:-}" ]; then
        enable_secrets_transit
        return
    fi
    
    # If dev mode is disabled and vault cluster is sealed.
    # Attempt to unseal the vault cluster
    if [ "${status_code}" = "501" ]; then
        unseal_vault
        enable_auth_userpass
        create_vault_operator_user
    fi
}

unseal_vault() {
    vault_init=$(vault operator init -recovery-shares=5 -recovery-threshold=3 -format=json)
    VAULT_ROOT_TOKEN=$(echo "${vault_init}" | jq -r '.root_token')
}

enable_secrets_transit() {
    VAULT_TOKEN="${VAULT_DEV_ROOT_TOKEN_ID}" vault secrets enable transit
    VAULT_TOKEN="${VAULT_DEV_ROOT_TOKEN_ID}" vault write -f transit/keys/unseal_key
}

enable_auth_userpass() {
    VAULT_TOKEN="${VAULT_ROOT_TOKEN}" vault auth enable userpass
    VAULT_TOKEN="${VAULT_ROOT_TOKEN}" vault auth tune -listing-visibility unauth userpass/
}

create_vault_operator_user() {
    VAULT_TOKEN="${VAULT_ROOT_TOKEN}" vault policy write vault-operator /vault/policies/vault-operator.hcl
    VAULT_TOKEN="${VAULT_ROOT_TOKEN}" vault write auth/userpass/users/vault-operator \
        password=vault-operator \
        policies=vault-operator
}

main
