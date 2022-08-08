ui = true
default_lease_ttl = "168h"
max_lease_ttl = "0h"

listener "tcp" {
  tls_disable = false
  address = "0.0.0.0:8200"
  tls_cert_file = "/vault/tls/vault.pem"
  tls_key_file = "/vault/tls/vault-key.pem"
  tls_min_version = "tls12"
}

storage "file" {
  path = "/vault/file"
}