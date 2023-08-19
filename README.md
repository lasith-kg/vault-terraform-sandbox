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
The following commands are to bootstrap a 5 Node, Highly Available, Vault Cluster
with Integrated Storage as the backend. Additionally, we enable Raft Auto-Pilot 
to ensure that dead servers are cleaned up appropriately
```
# Bootstrap Single Node Vault Cluster
make vault-up

# Scale Up Vault Cluster to 5 Nodes to Enable High Availability
make vault-scale-up

# Apply Base Vault Configuration Through Terraform
make terraform-init
make terraform-apply

# Get Vault Operator Userpass Credentials
make vault-operator-creds

# Open Vault UI (http://localhost:8080)
make vault-ui

# SSH into Vault Operator Container
# Within this container you can execute `vault` and `terraform` commands
#   e.g vault operator raft list-peers
#   e.g terraform state list
make vault-operator-ssh

# Deprovision Vault Cluster
make vault-down
```

## Terraform
The following commands execute `terraform` commands inside the `vault-operator` container
```
# Run `terraform init`
make terraform-init

# Run `terraform apply`
make terraform-apply
```
