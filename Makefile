# Define make variables
SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

# Define user variables
URL := http://localhost:8080

# Start the Vault containers using Docker Compose.
vault-up:
	docker compose up --remove-orphans -d --build

# Scale up the number of Vault containers to 5.
vault-scale-up:
	docker compose up --scale vault=5 -d --no-recreate

# Initialize Terraform in the vault-operator container.
terraform-init:
	docker compose exec vault-operator terraform init

# Create a Terraform plan and save it to terraform.plan.
terraform-plan:
	docker compose exec vault-operator terraform plan -out=terraform.plan

# Apply the Terraform plan with auto-approval.
terraform-apply:
	docker compose exec -it vault-operator terraform apply -auto-approve terraform.plan 

# SSH into the vault-operator container.
vault-operator-ssh:
	docker compose exec -it vault-operator /bin/sh -l

# Execute a script (credentials.sh) inside the vault-operator container.
vault-operator-creds:
	docker compose exec vault-operator credentials.sh

# Stop and remove all containers created by Docker Compose.
vault-down:
	docker compose down -v

# Stop the Vault leader container.
vault-stop-leader:
	container_id=`docker compose exec vault-operator get-node.sh leader`; \
	docker stop $$container_id

# Stop the Vault follower container.
vault-stop-follower:
	container_id=`docker compose exec vault-operator get-node.sh follower`; \
	docker stop $$container_id

# Open the Vault UI in a web browser (cross-platform).
vault-ui:
	@(open "$(URL)" || xdg-open "$(URL)") &> /dev/null || \
		echo "Visit $(URL) in the browser"