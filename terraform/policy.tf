resource "vault_policy" "vault-operator" {
  name = "vault-operator"
  policy = file("/terraform/policies/vault-operator.hcl")
}

import {
    id  = "vault-operator"
    to  = vault_policy.vault-operator
}
