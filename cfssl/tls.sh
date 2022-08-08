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
    #generate ca in $DIRECTORY
    cfssl gencert -initca /scripts/ca-csr.json | cfssljson -bare ca

    #generate certificate in /tmp
    cfssl gencert \
        -ca=ca.pem \
        -ca-key=ca-key.pem \
        -config=/scripts/ca-config.json \
        -hostname="localhost,127.0.0.1" \
        -profile=default \
        /scripts/ca-csr.json | cfssljson -bare vault
fi

