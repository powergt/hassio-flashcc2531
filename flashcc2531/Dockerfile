# 1. Stage di compilazione
ARG BUILD_FROM=ghcr.io/home-assistant/armv7-base:latest
FROM ${BUILD_FROM} AS builder

# Installa gli strumenti di compilazione
RUN apk add --no-cache \
    build-base \
    gcc \
    make \
    libc-dev

# Copia i sorgenti nella cartella di build
COPY src/ /build/
WORKDIR /build

# Compila (modifica il comando se il tuo file si chiama diversamente o hai un Makefile)
RUN gcc -o flash_cc2531 flash_cc2531.c

# 2. Stage finale (immagine pulita)
FROM ${BUILD_FROM}

# Installa le dipendenze minime per l'esecuzione
RUN apk add --no-cache \
    bash \
    ca-certificates

WORKDIR /data

# Copia il binario compilato dallo stage precedente
COPY --from=builder /build/flash_cc2531 /usr/local/bin/flash_cc2531

# Copia gli altri file necessari
COPY CC2531ZNP-Prod.hex /data/CC2531ZNP-Prod.hex
COPY run.sh /run.sh
COPY translations/ /translations/

RUN chmod a+x /run.sh /usr/local/bin/flash_cc2531

CMD [ "/run.sh" ]
