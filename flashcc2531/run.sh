#!/usr/bin/with-contenv bashio

FIRMWARE=$(bashio::config 'firmware')

bashio::log.info "Starting CC2531 flashing process..."
bashio::log.info "Selected firmware: ${FIRMWARE}"

if [ ! -f "/$FIRMWARE" ]; then
    bashio::log.error "Firmware file /${FIRMWARE} not found!"
    bashio::exit.nok
fi

bashio::log.info "Flashing via /dev/ttyAMA0..."

# Esecuzione del binario
if ./flash_cc2531 -p /dev/ttyAMA0 -f "$FIRMWARE"; then
    bashio::log.info "Flashing completed successfully!"
    bashio::exit.ok
else
    bashio::log.error "Flashing failed!"
    bashio::exit.nok
fi



