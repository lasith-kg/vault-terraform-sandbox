SHELL := /usr/bin/env bash
.SHELLFLAGS := -euo pipefail -c

vault-up:
	docker compose up --remove-orphans -d --build
vault-scale-up:
	docker compose up --scale vault=5 -d --no-recreate
terraform-init:
	docker compose exec vault-operator terraform init
terraform-plan:
	docker compose exec vault-operator terraform plan -out=terraform.plan
terraform-apply:
	docker compose exec -it vault-operator terraform apply -auto-approve terraform.plan 
vault-operator-ssh:
	docker compose exec -it vault-operator /bin/sh -l
vault-operator-creds:
	docker compose exec vault-operator credentials.sh
vault-down:
	docker compose down -v
vault-stop-leader:
	container_id=`docker compose exec vault-operator get-node.sh leader`; \
	docker stop $$container_id
vault-stop-follower:
	container_id=`docker compose exec vault-operator get-node.sh follower`; \
	docker stop $$container_id
URL := http://localhost:8080
vault-ui:
	(open "$(URL)" || xdg-open "$(URL)") &> /dev/null || \
		echo "Vist $(URL) in browser"
