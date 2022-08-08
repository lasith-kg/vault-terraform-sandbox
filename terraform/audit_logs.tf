resource "vault_audit" "vault_logs" {
  type = "file"

  options = {
    file_path = "/vault/logs/vault_audit.log"
  }
}