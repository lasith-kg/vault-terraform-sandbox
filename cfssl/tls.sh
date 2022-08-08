#!/bin/sh

ACTION="$1"
DIRECTORY="$2"

if [ -d "$DIRECTORY" ]; then
    cd "$DIRECTORY"
else
    echo "Directory $DIRECTORY does not exist"
    exit 1
fi

if [[ "$ACTION" == "generate" ]]; then
    # Generate ca in $DIRECTORY
    cfssl gencert -initca /scripts/ca-csr.json | cfssljson -bare ca/ca

    # Generate Vault Node Certificate
    cfssl gencert \
        -ca=ca/ca.pem \
        -ca-key=ca/ca-key.pem \
        -config=/scripts/ca-config.json \
        -hostname="vault,localhost,127.0.0.1" \
        -profile=default \
        /scripts/ca-csr.json | cfssljson -bare vault-node/vault

    # Generate Vault Operator Certificate
    cfssl gencert \
        -ca=ca/ca.pem \
        -ca-key=ca/ca-key.pem \
        -config=/scripts/ca-config.json \
        -profile=default \
        /scripts/ca-csr.json | cfssljson -bare vault-operator/vault

    # Clean Up
    rm */*.csr
    rm ca/ca-key.pem

    # Create Vault Linux User and Group
    addgroup vault
    adduser -S -G vault vault

    # Change Permissions of Public Certificates
    chmod 777 ca/ca.pem
    chmod 777 vault-node/vault.pem

    # Change Vault Node Key Permissions
    chmod 600 vault-node/vault-key.pem
    chown vault:vault vault-node/vault-key.pem

    # Change Vault Operator Key Permissions
    chmod 600 vault-operator/vault-key.pem
fi

