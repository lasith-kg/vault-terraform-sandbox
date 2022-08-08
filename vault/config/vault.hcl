ui = true
default_lease_ttl = "168h"
max_lease_ttl = "0h"

listener "tcp" {
  tls_disable = false
  address = "0.0.0.0:8200"
  tls_cert_file = "/etc/ssl/vault-node/vault.pem"
  tls_key_file = "/etc/ssl/vault-node/vault-key.pem"
  tls_min_version = "tls12"
}

storage "file" {
  path = "/vault/file"
}