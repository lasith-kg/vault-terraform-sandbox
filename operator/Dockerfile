FROM alpine:latest

RUN apk add curl jq

COPY --from=hashicorp/vault:latest /bin/vault /bin/vault
COPY --from=hashicorp/terraform:latest /bin/terraform /bin/terraform

WORKDIR /scripts
COPY *.sh .

ENTRYPOINT [ "/bin/sh", "-c" ]
