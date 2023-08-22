FROM alpine:latest

RUN apk add curl jq

COPY --from=hashicorp/vault:latest /bin/vault /bin/vault
COPY --from=hashicorp/terraform:latest /bin/terraform /bin/terraform

COPY .profile /root/.profile
COPY credentials.sh /usr/local/bin/credentials.sh
COPY get-node.sh /usr/local/bin/get-node.sh
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

WORKDIR "/terraform"
ENTRYPOINT [ "docker-entrypoint.sh" ]
