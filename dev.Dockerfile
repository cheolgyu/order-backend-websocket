FROM order-rust:latest

WORKDIR /usr/src/myapp

COPY . .
RUN RUSTC_WRAPPER=sccache  cargo build
EXPOSE 3001

#CMD [ "cargo", "watch","-x","run" ]