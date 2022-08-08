FROM alpine

# Depedencies
RUN apk add gcc g++

# Install Golang
COPY --from=golang:1.18-alpine /usr/local/go/ /usr/local/go/
ENV PATH "${PATH}:/usr/local/go/bin:/root/go/bin"

# Install cfssl + utilities
RUN go install github.com/cloudflare/cfssl/cmd/cfssljson@latest
RUN go install github.com/cloudflare/cfssl/cmd/cfssl@latest

WORKDIR /scripts
COPY tls.sh /scripts
COPY ca-*.json /scripts
ENTRYPOINT [ "/scripts/tls.sh" ]