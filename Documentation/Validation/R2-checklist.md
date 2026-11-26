# R2-DEV Design Review Status

> **Status:** Native KiCad 8 schematic (`KiCad/LoRa_DualBand.kicad_sch`), custom verified libraries (`LoRa_DualBand_Custom.*`), BOM (`Manufacturing/BOM_PCBWay_DRAFT.csv`, 0 TBD MPNs), and initial 4-layer routed PCB (`KiCad/LoRa_DualBand.kicad_pcb`) are complete. **Not yet approved for fabrication** until manual KiCad routing polish (45 remaining unrouted signal pairs + differential/RF tuning) and CI `kicad-cli` ERC/DRC verification pass.

- [x] Confirm exact RF module MPNs (`E22-400M22S` SX1268 433 MHz, `E22-900M22S` SX1262 868 MHz), Top-View land pattern (`Ebyte_E22-M22S_14x20mm`), opposite-edge SMAs (`J2` top, `J3` bottom), and independent RF filtering (`FL1` `LFCN-490+` LPF 433 MHz; `FL2` `HFCN-740+` + `FL3` `LFCN-900+` bidirectional 7 W BPF 868 MHz).
- [x] Map every `STM32G0B1RET6` (LQFP-64) pin cleanly with zero pin or EXTI conflicts (`USART1/2/3/5` + `LPUART2`, `SPI1/2`, `EXTI5` vs `EXTI9`, `16 MHz` HSE `Y3`, `PA14-BOOT0` shared with `SWCLK`). *(Final CubeMX DMA/AF check still recommended before firmware bring-up.)*
- [x] Complete `FT4232HL` power rails (`VPHY`/`VPLL` ferrites + decoupling, `VCORE` 1.8 V bypass), `12 MHz` crystal (`Y1`), `93LC56BT-I/SN` EEPROM (`U12`), `12 kΩ` `REF`, `TEST→GND`, and `RESET#`.
- [x] Complete `USB2422-I/MJ` hub (`U6`) `24 MHz` crystal (`Y2`), `12 kΩ` `RBIAS`, `OCS1/2_N` + `NON_REM1` + `CFG_SEL0` straps, `RESET_N` RC, `CRFILT`/`PLLFILT` caps, and `VBUS_DET` divider.
- [x] Complete `STM32U073CCT6` (`U7`) power, decoupling (`C4..C10`), `PF3-BOOT0` (`R13`), `PF2-NRST` (`C3`), dedicated programming SWD (`J7`), and USB FS interface (`PA11/PA12`).
- [x] Select bidirectional `Ioff` FET bus switches (`U8`, `U11` = `SN74CB3Q3126PWR`, active-HIGH `OE`) and load switch (`U9` = `TPS22918DBVR`, active-HIGH `ON`, `CT = 1 nF`), with default-OFF `DEBUG_EN` (`R11 = 10 kΩ`) and `1 kΩ` protection (`R52`) on `J5`.
- [x] Use standard Cortex Debug 10-pin 1.27 mm SMD header (`J4` = `FTSH-105-01-L-DV-K`) with `VTREF` sense.
- [x] USB-C male plug (`J1` = `DX07P024AJ1`) `5.1 kΩ` `CC` (`R1`), flow-through ESD (`D1` = `USBLC6-2SC6`), `SMAJ5.0A` TVS (`D2`), and `C21 = 4.7 µF` (`≤ 10 µF` USB inrush limit).
- [x] Auxiliary USB-C input (`J6` = `TYPE-C-31-M-12`, DNP Basic) with independent `5.1 kΩ` `R2`/`R3` on `CC1`/`CC2`, `SMAJ5.0A` (`D3`), `TPS2121RUXR` (`U10`) power mux (DNP Basic, mutually exclusive with `SJ1`), and `2× 220 µF` 1210 (`C1A`/`C1B`, DNP Basic) after inrush control.
- [x] Sync buck `U5` (`TPS562201DDCR`, 2 A, 4.5–17 V in, `IHLP1616ABER3R3M01` `3.3 µH`) sized with >4× margin over worst-case 440 mA load.
- [x] Place 0603/0805 `0 Ω` isolation links on all subsystem power rails (`R_PWR_3V3/U6/U1/U2/U7`, `FB1/FB2`) and all 36 MCU digital lines (`R101..R118`, `R121..R129`, `R131..R139`) + 16 bench test points (`TP1..TP16`) and 3 optical fiducials (`FID1..FID3`); zero stubs on USB HS or RF lines.
- [x] Native KiCad 8 schematic (`KiCad/LoRa_DualBand.kicad_sch`, 222 components, 0 ERC errors in generator) and 4-layer PCB (`KiCad/LoRa_DualBand.kicad_pcb`, 0 placement overlaps, solid `In1.Cu` GND plane, `In2.Cu` `3V3`+`GND` planes, RF stitching via fence, 85.6% signal pairs auto-routed).
- [ ] Complete manual routing cleanup in KiCad PCB Editor for the remaining 45 signal pairs + length-match USB 90 Ω differential pairs + tune RF 50 Ω CPWG + verify `kicad-cli` ERC & DRC = 0 violations in CI.
- [ ] Verify physical bench measurements (power consumption, backfeed `< 0.1 V`, RF coexistence / harmonic suppression on spectrum analyzer, and RF coexistence manager firmware on `STM32G0B1`).
- [ ] Finalize CPL rotations, Gerber review, and fabrication sign-off (`Manufacturing/APPROVED`).
