# This file is part of Mooij Forensics (https://www.mooijforensics.com/)
# Copyright (C) 2022 Marten Mooij (https://www.mooijtech.com/)
FROM golang:1.16.0-alpine3.13

WORKDIR /go/src/goforensics
ADD . /go/src/goforensics

RUN apk update
RUN apk add --no-cache git build-base

RUN go build /go/src/goforensics/cmd/api.go

# We use a Docker multi-stage build here in order that we only take the compiled go executable
FROM alpine:3.13

COPY --from=0 "/go/src/goforensics/api" api
RUN mkdir data/

ENTRYPOINT ./api