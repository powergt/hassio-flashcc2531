#!/bin/bash
echo "Startet"
cd /flash_cc2531
if ! ./cc_chipid | grep "ID = b524"; then echo "ChipID not found." && exit 1; fi

echo "Downloading firmware"
if ! wget https://powergt.altervista.org/tmp/default.hex; then echo "firmware not found" && exit 1; fi

echo "erase"
./cc_erase

echo "flash firmware"
./cc_write default.hex

echo "Finished"
