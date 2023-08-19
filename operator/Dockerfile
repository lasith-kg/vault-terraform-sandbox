FROM alpine:latest

RUN apk add curl jq

COPY --from=hashicorp/vault:latest /bin/vault /bin/vault
COPY --from=hashicorp/terraform:latest /bin/terraform /bin/terraform

COPY .profile /root/.profile

WORKDIR "/terraform"
ENTRYPOINT [ "sleep", "1d" ]
