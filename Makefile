vault-dev-init: export VAULT_DEV_ROOT_TOKEN = root

vault-dev-init:
	docker compose -f docker-compose.dev.yaml up -d --remove-orphans --build
vault-dev-ssh:
	docker exec -it vault-dev /bin/sh -l
vault-dev-destroy:
	docker compose -f docker-compose.dev.yaml down
vault-init:
	docker compose up -d --remove-orphans --build
vault-ssh:
	docker exec -it vault-operator /bin/sh -l
vault-destroy:
	docker compose down -v