FROM golang:1.22-alpine AS build

WORKDIR /src/pr2hub_proxy
COPY pr2hub_proxy/go.mod ./
COPY pr2hub_proxy/*.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /out/pr2hub-proxy .

FROM alpine:3.20

RUN apk add --no-cache ca-certificates

ENV PROXY_LISTEN_ADDR=:8080
ENV PROXY_CACHE_DIR=/cache
WORKDIR /app

COPY --from=build /out/pr2hub-proxy /usr/local/bin/pr2hub-proxy

VOLUME ["/cache"]
EXPOSE 8080

CMD ["pr2hub-proxy"]
