# 1. Stage di compilazione
ARG BUILD_FROM=ghcr.io/home-assistant/armv7-base:latest
FROM ${BUILD_FROM} AS builder

RUN apk add --no-cache build-base gcc

# Copia i sorgenti
COPY src/ /build/
WORKDIR /build

# Compilazione dei tre strumenti distinti
RUN gcc -o cc_chipid cc_chipid.c && \
    gcc -o cc_erase cc_erase.c && \
    gcc -o cc_write cc_write.c

# 2. Stage finale
FROM ${BUILD_FROM}
RUN apk add --no-cache bash

WORKDIR /data

# Copia i binari compilati
COPY --from=builder /build/cc_chipid /usr/local/bin/
COPY --from=builder /build/cc_erase /usr/local/bin/
COPY --from=builder /build/cc_write /usr/local/bin/

# Copia file necessari e script
COPY CC2531ZNP-Prod.hex /data/CC2531ZNP-Prod.hex
COPY run.sh /run.sh
RUN chmod a+x /run.sh /usr/local/bin/cc_*

CMD [ "/run.sh" ]
