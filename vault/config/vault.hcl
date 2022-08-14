ui = true
default_lease_ttl = "168h"
max_lease_ttl = "0h"
api_addr = "https://127.0.0.1:8200"
cluster_addr = "https://127.0.0.1:8201"

listener "tcp" {
  tls_disable = false
  address = "0.0.0.0:8200"
  tls_cert_file = "/etc/ssl/vault-node/vault.pem"
  tls_key_file = "/etc/ssl/vault-node/vault-key.pem"
  tls_min_version = "tls12"
}

storage "raft" {
  path = "/vault/file"
  node_id = "node01"
}