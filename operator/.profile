#!/bin/sh

# Get Vault Operator Vault Token
export VAULT_TOKEN="$(vault login \
    --method=userpass \
    "username=${TERRAFORM_VAULT_USERNAME}" \
    "password=${TERRAFORM_VAULT_PASSWORD}" \
    -format=json | jq -r '.auth.client_token')"
