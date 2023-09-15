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

- Linux [[Install Guide](https://docs.docker.com/desktop/install/linux-install/)]
- MacOS [[Install Guide](https://docs.docker.com/desktop/install/mac-install/)]

## Vault

The following commands are to bootstrap a 5 Node, Highly Available, Vault Cluster
with Integrated Storage as the backend. Additionally, we enable Raft Auto-Pilot
to ensure that dead servers are cleaned up appropriately

```
# Bootstrap Single Node Vault Cluster
make vault-up

# Enable High Availability by Scaling Up Vault Cluster to 5 Nodes (Optional)
make vault-scale-up

# Apply Raft Autopilot Configuration Through Terraform
make terraform-init
make terraform-plan
make terraform-apply

# Get Vault Operator `/userpass` Credentials
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

# Run `terraform plan -out=terraform.plan`
make terraform-plan

# Run `terraform apply -auto-approve terraform.plan`
make terraform-apply
```

## Disaster Simulation

The following commands can be executed to simulate disaster events like a Node being terminated or losing communication with the Vault cluster.
Once high-availability is enabled, you can opt to either terminate a follower or leader node. The latter option allowing us to witness the leader re-election process.
```
# Stop a Follower Node
make vault-stop-follower

# Stop a Leader Node
make vault-stop-leader

# Restore Vault Cluster to Healthy State (5 Nodes)
make vault-scale-up
```

