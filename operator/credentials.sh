#!/bin/sh

cat << EOF
Auth Method:    /userpass
Username:       ${TERRAFORM_VAULT_USERNAME}
Password:       ${TERRAFORM_VAULT_PASSWORD}
EOF
