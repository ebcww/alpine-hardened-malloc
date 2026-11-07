FROM alpine:latest
RUN apk update ; apk upgrade ; apk add git make clang gcc g++
WORKDIR /tmp
RUN git clone https://github.com/GrapheneOS/hardened_malloc
WORKDIR /tmp/hardened_malloc
RUN git reset --hard bf37d54 ; git restore . ; git clean -dfx ; make CONFIG_NATIVE=false ; mv out /usr/local/lib/hardened_malloc ; rm -rf /tmp/hardened_malloc ; apk del git make clang ; echo "/usr/local/lib/hardened_malloc/libhardened_malloc.so" > /etc/ld.so.preload
ENV LD_PRELOAD=/usr/local/lib/hardened_malloc/libhardened_malloc.so
WORKDIR /
