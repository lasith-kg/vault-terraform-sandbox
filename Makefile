MAKEFLAGS += --silent

vault-up:
	docker compose up --remove-orphans -d --build
vault-enable-ha:
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
vault-ui:
	open 'http://localhost:8080'
vault-down:
	docker compose down -v