# Physical component libraries

Use the official KiCad symbol and footprint libraries installed by the Dockerfile. Do not use the R1 logical cache symbols for a production netlist.

| Reference | Part | Symbol library / candidate ID | Footprint |
|---|---|---|---|
| U1 | FT4232HL | Interface_USB:FT4232H | Package_QFP:LQFP-64_10x10mm_P0.5mm |
| U2 | STM32G0B1RET6 | MCU_ST_STM32G0:STM32G0B1RETx | Package_QFP:LQFP-64_10x10mm_P0.5mm |
| U7 | STM32F072CBT6 | MCU_ST_STM32F0:STM32F072CBTx (candidate) | Package_QFP:LQFP-48_7x7mm_P0.5mm |
| U6 | USB2422 | Interface_USB (verify symbol) | verify exact package |
| U10 | TPS2121 | Power_Management (verify symbol) | verify exact package |
| U3 | 433 MHz SPI TCXO module | pending exact MPN | pending manufacturer land pattern |
| U4 | 868 MHz SPI TCXO module | pending exact MPN | pending manufacturer land pattern |

FTDI and STM32 identifiers are candidates from library catalogues; CI must verify installed files and symbols. Do not substitute a bare SX1262 footprint for a module. Ebyte E22-400M22S uses SX1268, not SX1262; E22-900M22S uses SX1262. Confirm whether SX1268 is acceptable before selection. The R2 schematic still uses logical placeholders.

Official libraries: https://gitlab.com/kicad/libraries/kicad-symbols and https://gitlab.com/kicad/libraries/kicad-footprints
RF candidates: https://www.cdebyte.com/products/E22-900M22S/1 and https://ebyteiot.com/pt/products/e22-series-semtech-sx1262-sx1268-ultra-small-smd-lora-module-22dbm-6km-spi-tcxo
