# Vault Terraform Sandbox

## Prerequisites
### make
```
# Linux
sudo apt-get update
sudo apt-get install build-essential

# MacOS
sudo xcode-select --install
```
### docker + docker compose
* Linux [[Install Guide](https://docs.docker.com/desktop/install/linux-install/)]
* MacOS [[Install Guide](https://docs.docker.com/desktop/install/mac-install/)]

## Vault

```
# Bootstrap Single Node Vault Cluster
make vault-init

# SSH into Vault Node
make vault-ssh

# Print Root Vault Token
make vault-print-root-token

# Open Vault UI console
make vault-ui

# Destroy Vault Cluster + Terraform State Files
make vault-destroy
```

## Terraform 
```
# Running `terraform init` command
make terraform-init

# Running `terraform apply` command
make terraform-apply
```
