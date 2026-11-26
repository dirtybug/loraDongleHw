#!/usr/bin/env bash
set -euo pipefail
SCH=KiCad/LoRa_DualBand.kicad_sch
PCB=KiCad/LoRa_DualBand.kicad_pcb
mkdir -p output/pdf output/checks
kicad-cli version > output/checks/version.txt
if [[ ! -f "$SCH" || ! -f "$PCB" ]]; then
  echo "Missing native KiCad schematic or PCB. No manufacturing output generated." | tee output/checks/status.txt
  exit 1
fi
kicad-cli sch export pdf -o output/pdf/schematic.pdf "$SCH"
kicad-cli pcb export pdf --layers F.Cu,F.Silkscreen,Edge.Cuts -o output/pdf/pcb-top.pdf "$PCB"
kicad-cli pcb export pdf --layers B.Cu,B.Silkscreen,Edge.Cuts -o output/pdf/pcb-bottom.pdf "$PCB"
kicad-cli sch erc --exit-code-violations -o output/checks/erc.txt "$SCH"
kicad-cli pcb drc --exit-code-violations -o output/checks/drc.txt "$PCB"
if [[ ! -f Manufacturing/APPROVED ]]; then
  echo "Engineering approval missing. PDFs are development documents only." | tee output/checks/status.txt
  exit 1
fi
mkdir -p output/pcbway
kicad-cli pcb export gerbers --layers F.Cu,In1.Cu,In2.Cu,B.Cu,F.Mask,B.Mask,F.Silkscreen,B.Silkscreen,F.Paste,B.Paste,Edge.Cuts -o output/pcbway/ "$PCB"
kicad-cli pcb export drill --format excellon --generate-map --map-format pdf -o output/pcbway/ "$PCB"
kicad-cli sch export bom --fields 'Reference,Value,Footprint,${QUANTITY},MPN,Manufacturer,${DNP}' --labels 'Reference,Value,Footprint,Quantity,MPN,Manufacturer,DNP' -o output/bom.csv "$SCH"
kicad-cli pcb export pos --format csv --units mm --side both --exclude-dnp -o output/pick-and-place.csv "$PCB"
(cd output/pcbway && zip -r ../PCBWay-Gerbers-Drill.zip .)
