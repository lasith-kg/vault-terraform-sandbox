FROM hashicorp/vault:latest as base

RUN apk update && apk add gettext curl jq
COPY initialise.sh /usr/local/bin/initialise.sh
COPY docker-entrypoint.sh /usr/local/bin/.docker-entrypoint.sh
ENTRYPOINT [".docker-entrypoint.sh"]
