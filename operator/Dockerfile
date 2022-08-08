FROM alpine:latest

RUN apk add curl jq

COPY --from=vault:latest /bin/vault /bin/vault
COPY --from=hashicorp/terraform:latest /bin/terraform /bin/terraform

ENTRYPOINT [ "/bin/sh", "-c" ]