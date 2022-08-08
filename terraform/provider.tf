variable "vault_address" {
    type = string
    default = "https://vault:8200"
}

variable "vault_token" { type = string }
variable "vault_ca_cert_file" { type = string }
variable "vault_cert_file" { type = string }
variable "vault_key_file" { type = string }

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
  ca_cert_file = var.vault_ca_cert_file
  
  client_auth {
     cert_file = var.vault_cert_file
     key_file = var.vault_key_file
  }
}

terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "3.8.1"
    }
  }
}