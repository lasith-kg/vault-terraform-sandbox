#!/bin/sh

# Get Vault Operator Vault Token
VAULT_TOKEN="$(vault login \
    --method=userpass \
    "username=${TERRAFORM_VAULT_USERNAME}" \
    "password=${TERRAFORM_VAULT_PASSWORD}" \
    -format=json | jq -r '.auth.client_token')"

echo "Vault Address:    ${VAULT_ADDR}"
echo "Vault Token:      ${VAULT_TOKEN:0:7}***"

