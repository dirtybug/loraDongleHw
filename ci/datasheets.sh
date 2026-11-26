#!/usr/bin/env bash
set -uo pipefail
mkdir -p output/datasheets
failed=0
while read -r name url; do
  if curl --fail --location --retry 2 --max-time 90 "$url" -o "output/datasheets/$name.tmp" && head -c 5 "output/datasheets/$name.tmp" | grep -q '%PDF-'; then
    mv "output/datasheets/$name.tmp" "output/datasheets/$name"
  else
    rm -f "output/datasheets/$name.tmp"
    echo "Failed: $name" >&2
    failed=1
  fi
done <<'URLS'
STM32G0B1.pdf https://www.st.com/resource/en/datasheet/stm32g0b1cb.pdf
FT2232H.pdf https://ftdichip.com/wp-content/uploads/2024/03/DS_FT2232H.pdf
USB2422.pdf https://ww1.microchip.com/downloads/en/DeviceDoc/00001726B.pdf
RP2040.pdf https://datasheets.raspberrypi.com/rp2040/rp2040-datasheet.pdf
TPS2121.pdf https://www.ti.com/lit/ds/symlink/tps2121.pdf
URLS
exit "$failed"
