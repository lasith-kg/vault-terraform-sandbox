resource "vault_auth_backend" "userpass" {
  type = "userpass"

  tune {
    listing_visibility = "unauth"
  }
}

import {
    id  = "userpass"
    to  = vault_auth_backend.userpass
}

resource "vault_generic_endpoint" "vault-operator-user" {
  depends_on           = [vault_auth_backend.userpass,
                          vault_policy.vault-operator,]
  path                 = "auth/userpass/users/vault-operator"
  ignore_absent_fields = true

  data_json            = <<EOT
{
  "policies": ["${vault_policy.vault-operator.name}"],
  "username": "vault-operator"
}
EOT
}
