ARG BUILD_FROM=ghcr.io/home-assistant/armv7-base:latest
FROM ${BUILD_FROM}

# Imposta la directory di lavoro
WORKDIR /data

# Installa le dipendenze necessarie (se servono librerie dinamiche)
RUN apk add --no-cache \
    bash \
    jq

# Copia i file dell'addon
COPY flash_cc2531 /flash_cc2531
COPY default.hex /default.hex
COPY run.sh /run.sh

# Rendi eseguibili i file
RUN chmod a+x /run.sh /flash_cc2531

CMD [ "/run.sh" ]
