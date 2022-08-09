MAKEFLAGS += --silent
vault-dev-init: export VAULT_DEV_ROOT_TOKEN = root

# Dev Vault Node
vault-dev-init:
	docker compose -f docker-compose.dev.yaml up --remove-orphans --build -d
vault-dev-ssh:
	docker exec -it vault-dev /bin/sh -l
vault-dev-destroy:
	docker compose -f docker-compose.dev.yaml down

# Pseudo-prod Vault Node
vault-init:
	docker compose up --remove-orphans --build -d
vault-ssh:
	docker exec -it vault-operator /bin/sh -l
vault-terraform-init:
	docker exec vault-operator /bin/sh -l -c './terraform.sh init'
vault-terraform-apply:
	docker exec -it vault-operator /bin/sh -l -c './terraform.sh apply'
vault-print-root-token:
	docker exec vault-operator /bin/sh -l -c 'echo $$VAULT_TOKEN'
vault-destroy:
	docker compose down -v
	# Clean Terraform Vault State Files
	find ./terraform -regex "\./terraform/\.*terraform.*" | xargs rm -rf
	# Clean Vault Logs
	find ./vault -regex "\./vault/logs/.*" | xargs rm -rf