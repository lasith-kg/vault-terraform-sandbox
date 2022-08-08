resource "vault_mount" "kv" {
  path        = "kv"
  type        = "kv-v2"
  description = "KV store for prod services"
}