FROM rust:latest

RUN apt-get update

RUN apt-get install musl-tools -y

RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /usr/src/myapp

COPY Cargo.toml Cargo.toml

RUN mkdir src/

RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl
# order_backend_websocket 주의 - _ 
RUN rm -f /usr/src/myapp/target/x86_64-unknown-linux-musl/release/deps/order_backend_websocket*

COPY . .

RUN RUSTFLAGS=-Clinker=musl-gcc cargo build --release --target=x86_64-unknown-linux-musl

# $(aws ecr get-login --no-include-email --region ap-northeast-2)
# docker build -f "ecr.base.Dockerfile" -t base_websocket .
# docker tag base_websocket:latest 410450153592.dkr.ecr.ap-northeast-2.amazonaws.com/base:base_websocket_latest
# docker push 410450153592.dkr.ecr.ap-northeast-2.amazonaws.com/base:base_websocket_latest