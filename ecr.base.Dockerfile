FROM rust:slim

WORKDIR /usr/src/myapp
RUN rm -f target/x86_64-unknown-linux-musl/release/deps/order-backend-websocket*
RUN mkdir src/
RUN echo "fn main() {println!(\"if you see this, the build broke\")}" > src/main.rs
COPY Cargo.toml Cargo.toml
RUN cargo build --release

CMD ["myapp"]

# $(aws ecr get-login --no-include-email --region ap-northeast-2)
# docker build -t base_websocket .
# docker tag base_websocket:latest 410450153592.dkr.ecr.ap-northeast-2.amazonaws.com/base:base_websocket_latest
# docker push 410450153592.dkr.ecr.ap-northeast-2.amazonaws.com/base:base_websocket_latest