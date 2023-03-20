MAKEFLAGS += --silent

vault-init:
	docker compose up --remove-orphans --build -d
vault-ssh:
	docker exec -it vault-operator /bin/sh -l
vault-print-root-token:
	docker exec vault-operator /bin/sh -l -c 'echo $$VAULT_TOKEN'
vault-ui:
	open 'https://localhost:8200'
vault-destroy:
	docker compose down -v
	# Clean Terraform Vault State Files
	find ./terraform -regex "\./terraform/\.*terraform.*" | xargs rm -rf
	# Clean Vault Logs
	find ./vault -regex "\./vault/logs/.*" | xargs rm -rf
terraform-init:
	docker exec vault-operator /bin/sh -l -c './terraform.sh init'
terraform-apply:
	docker exec -it vault-operator /bin/sh -l -c './terraform.sh apply'
