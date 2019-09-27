#https://shaneutt.com/blog/rust-fast-small-docker-image-builds/
# ------------------------------------------------------------------------------
# Cargo Build Stage
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Final Stage
# ------------------------------------------------------------------------------

ARG BASE_IMAGE=410450153592.dkr.ecr.ap-northeast-2.amazonaws.com/base:base_websocket_latest
FROM ${BASE_IMAGE} AS cargo-build

COPY . .
COPY .env.production .env

RUN cargo build --release 
WORKDIR /home/myapp/bin/

CMD ["./order-backend-websocket"]