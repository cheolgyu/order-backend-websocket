FROM localhost:5000/order-rust:latest

RUN echo $RUSTC_WRAPPER
WORKDIR /usr/src/myapp

COPY . .
RUN cargo build
EXPOSE 3001

CMD [ "cargo", "watch","-x","run" ]