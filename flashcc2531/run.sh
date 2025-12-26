#!/usr/bin/with-contenv bashio

FIRMWARE=$(bashio::config 'firmware')

bashio::log.info "--- Inizio procedura Flash CC2531 ---"

# 1. Verifica CHIP ID
bashio::log.info "Verifica identificativo del chip..."
CHIP_ID=$(cc_chipid)

if [[ "$CHIP_ID" == *"ID = b524"* ]]; then
    bashio::log.info "Chip rilevato correttamente: ID = b524"
else
    bashio::log.error "Errore: Chip non trovato o ID errato!"
    bashio::log.error "Output ricevuto: $CHIP_ID"
    bashio::exit.nok
fi

# 2. Cancellazione (Erase)
bashio::log.info "Cancellazione del chip in corso..."
if cc_erase; then
    bashio::log.info "Cancellazione completata."
else
    bashio::log.error "Errore durante la cancellazione (cc_erase)!"
    bashio::exit.nok
fi

# 3. Scrittura (Write)
bashio::log.info "Scrittura del firmware: ${FIRMWARE}..."
if [ ! -f "/data/$FIRMWARE" ]; then
    bashio::log.error "File firmware /data/${FIRMWARE} non trovato!"
    bashio::exit.nok
fi

if cc_write "/data/$FIRMWARE"; then
    bashio::log.green "Flash completato con successo!"
    bashio::exit.ok
else
    bashio::log.error "Errore durante la scrittura (cc_write)!"
    bashio::exit.nok
fi
