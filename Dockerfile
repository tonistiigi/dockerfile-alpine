# syntax=docker/dockerfile-upstream:master-labs

ARG ALPINE_REPO=alpine
ARG ALPINE_VERSION=edge

FROM --platform=$BUILDPLATFORM tonistiigi/xx@sha256:21a61be4744f6531cb5f33b0e6f40ede41fa3a1b8c82d5946178f80cc84bfc04 AS xx

FROM --platform=$BUILDPLATFORM ${ALPINE_REPO}:${ALPINE_VERSION} AS builder
COPY --from=xx / /
ARG ALPINE_VERSION TARGETARCH
RUN <<-eof
  set -e
  mkdir -p /out/etc/apk/
  echo https://dl-cdn.alpinelinux.org/alpine/${ALPINE_VERSION}/main >> /out/etc/apk/repositories
  if [ "${TARGETARCH}"  != "riscv64" ]; then
    echo https://dl-cdn.alpinelinux.org/alpine/${ALPINE_VERSION}/community >> /out/etc/apk/repositories
  fi
  cp -a /etc/alpine-release /etc/issue /etc/os-release /out/etc/
  echo $(xx-info alpine-arch) > /out/etc/apk/arch
  apk add --no-cache --initdb -p /out --allow-untrusted alpine-keys
  for f in $(cat /etc/apk/world); do
    apk add --no-cache -p /out $f
  done
eof

FROM scratch AS alpine-fromsource
COPY --from=builder /out /
CMD ["/bin/sh"]

FROM ${ALPINE_REPO}:${ALPINE_VERSION} AS alpine-release

FROM alpine-fromsource AS alpine-riscv64

FROM alpine-release AS alpine-amd64
FROM alpine-release AS alpine-arm64
FROM alpine-release AS alpine-armv7
FROM alpine-release AS alpine-armv6
FROM alpine-release AS alpine-ppc64le
FROM alpine-release AS alpine-s390x

FROM alpine-${TARGETARCH}${TARGETVARIANT}