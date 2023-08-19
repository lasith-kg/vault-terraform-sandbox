MAKEFLAGS += --silent

vault-up:
	docker compose up --remove-orphans -d --build
vault-scale-up:
	docker compose up --scale vault=5 -d --no-recreate
vault-down:
	# Clear Terraform State Files
	docker compose exec -it vault-operator /bin/sh -c \
		'find /terraform -regex "/terraform/\.*terraform.*" | xargs rm -rf' \
	|| true
	docker compose down -v
vault-operator-ssh:
	docker compose exec -it vault-operator /bin/sh -l
vault-operator-creds:
	docker compose exec -it vault-operator /bin/sh -c \
	'echo -e "Auth Method:\tuserpass\nUsername:\t$${TERRAFORM_VAULT_USERNAME}\nPassword:\t$${TERRAFORM_VAULT_PASSWORD}"'
vault-ui:
	open 'http://localhost:8080'
terraform-init:
	docker compose exec vault-operator terraform init
terraform-apply:
	docker compose exec -it vault-operator terraform apply
