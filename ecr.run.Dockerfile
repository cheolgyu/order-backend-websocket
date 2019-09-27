#https://shaneutt.com/blog/rust-fast-small-docker-image-builds/
# ------------------------------------------------------------------------------
# Cargo Build Stage
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Final Stage
# ------------------------------------------------------------------------------
ARG BASE_IMAGE=410450153592.dkr.ecr.ap-northeast-2.amazonaws.com/base:base_websocket_latest
FROM ${BASE_IMAGE} AS cargo-build
COPY .env.production .env
COPY . .

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

FROM alpine:latest

RUN addgroup -g 1000 myapp

RUN adduser -D -s /bin/sh -u 1000 -G myapp myapp

WORKDIR /home/myapp/bin/

COPY --from=cargo-build /usr/src/myapp/target/x86_64-unknown-linux-musl/release/order-backend-websocket .
COPY --from=cargo-build /usr/src/myapp/.env.production .env

RUN chown myapp:myapp order-backend-websocket

USER myapp

CMD ["./order-backend-websocket"]