vault-dev-init: export VAULT_DEV_ROOT_TOKEN = root

vault-dev-init:
	docker compose -f docker-compose.dev.yaml up -d
vault-dev-ssh:
	docker exec -it vault-dev /bin/sh
vault-dev-stop:
	docker compose -f docker-compose.dev.yaml down
vault-init:
	docker compose up -d
vault-ssh:
	docker exec -it vault /bin/sh
vault-stop:
	docker compose down
