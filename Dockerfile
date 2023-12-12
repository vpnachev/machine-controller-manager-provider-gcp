#############      builder                          #############
FROM golang:1.20.5 AS builder

WORKDIR /go/src/github.com/gardener/machine-controller-manager-provider-gcp
COPY . .

RUN .ci/build

#############      machine-controller               #############
FROM alpine:3 AS machine-controller
WORKDIR /

COPY --from=builder /go/src/github.com/gardener/machine-controller-manager-provider-gcp/bin/rel/machine-controller /machine-controller
ENTRYPOINT ["/machine-controller"]
