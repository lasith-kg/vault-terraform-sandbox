ui = true
default_lease_ttl = "168h"
max_lease_ttl = "0h"

listener "tcp" {
  tls_disable = true
  address = "0.0.0.0:8200"
}

storage "file" {
  path = "/vault/file"
}