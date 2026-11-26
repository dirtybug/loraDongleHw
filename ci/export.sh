#!/usr/bin/env bash
set -euo pipefail
SCH=KiCad/LoRa_DualBand.kicad_sch
PCB=KiCad/LoRa_DualBand.kicad_pcb
mkdir -p output/pdf output/checks
kicad-cli version > output/checks/version.txt
if [[ ! -f "$SCH" ]]; then SCH=KiCad/LoRa_DualBand.sch; fi
test -f "$SCH" && test -f "$PCB"
failed=0
kicad-cli sch export pdf -o output/pdf/schematic.pdf "$SCH" || failed=1
kicad-cli pcb export pdf --layers F.Fab,F.Silkscreen,Edge.Cuts -o output/pdf/pcb-top.pdf "$PCB" || failed=1
kicad-cli pcb export pdf --layers B.Cu,B.Silkscreen,Edge.Cuts -o output/pdf/pcb-bottom.pdf "$PCB" || failed=1
python3 ci/bom_pdf.py || failed=1
kicad-cli sch erc --exit-code-violations -o output/checks/erc.txt "$SCH" || failed=1
kicad-cli pcb drc --exit-code-violations -o output/checks/drc.txt "$PCB" || failed=1
if [[ ! -f Manufacturing/APPROVED || "$SCH" != *.kicad_sch ]] || ! grep -q '(footprint ' "$PCB" || ! grep -q '(segment ' "$PCB"; then
  echo "DRAFT ONLY: fabrication blocked; no approved routed native design." | tee output/checks/status.txt
  exit "$failed"
fi
if [[ "$failed" != 0 ]]; then exit 1; fi
# Production is intentionally disabled until revision-specific approval and variant BOM/CPL validation are implemented.
echo "Production release gate not implemented." | tee output/checks/status.txt
exit 1
