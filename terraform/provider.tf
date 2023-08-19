provider "vault" {
# address = ""      Set by VAULT_ADDR
  auth_login_userpass {
#   username = ""   Set by TERRAFORM_VAULT_USERNAME
#   password = ""   Set by TERRAFORM_VAULT_PASSWORD
  }
}

terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.19.0"
    }
  }
}
