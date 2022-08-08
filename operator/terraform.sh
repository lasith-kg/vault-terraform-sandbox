#!/bin/sh -l

# VAULT_TOKEN is retrieved from ~/.profile since shebang opens shell in login mode
if [ -z ${VAULT_TOKEN+x} ]; then echo "FATAL: 🔴 envvar VAULT_TOKEN must be set"; exit 1; fi

ACTION="$1"
DIRECTORY="/terraform"

if [ -d "$DIRECTORY" ]; then
    cd "$DIRECTORY"
else
    echo "Directory $DIRECTORY does not exist."
    exit 1
fi

if [[ "$ACTION" == "init" ]]; then
    terraform init
elif [[ "$ACTION" == "apply" ]]; then
    terraform apply \
        -var="vault_token=${VAULT_TOKEN}" \
        -var-file="variables.tfvars"
fi

