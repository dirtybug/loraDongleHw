# R2 design review — OPEN, not fabrication-ready
- [ ] Confirm exact RF module MPNs, TCXO voltage, RXEN/TXEN or internal DIO2 switching, manufacturer top-view land pattern and 50-ohm launch.
- [ ] Verify every STM32G0B1RET6 pin and alternate function against exact package in CubeMX: four USART with RTS/CTS, fifth UART, two SPI, IRQ/BUSY/RESET, RF switch control and DMA.
- [ ] Complete FT4232HL power rails, 12 MHz clock, EEPROM, REF, TEST and reset per reference design.
- [ ] Complete USB2422 hub clock, RBIAS, configuration straps, reset, bus/self-power reporting and VBUS sensing.
- [ ] Complete STM32U073CCT6 power, decoupling, BOOT0, NRST, dedicated programming SWD, USB clock/CRS and USB interface per ST reference; validate CMSIS-DAP plus CDC firmware.
- [ ] Select physical SWD and UART isolation devices, check bidirectional SWDIO and NRST, powered-off leakage and default safe enable state. Test debugger disabled with target powered and vice versa.
- [ ] Use standard Cortex Debug 10-pin keyed connector, verify pinout and target voltage sensing.
- [ ] USB-C plug CC termination, ESD, controlled impedance and inrush.
- [ ] USB auxiliary input with independent Rd on CC1/CC2 and power mux; mutually exclusive bypass. Verify Basic variant also has current limiting and controlled bulk capacitance.
- [ ] Verify power consumption and backfeed in all variants and suspend states, including dual RF transmission and external-only power.
- [ ] Place 0603 zero-ohm links and both-side test points on all five UARTs, both SPIs and radio control nets; avoid USB and RF stubs.
- [ ] Verify BOOT0, NRST, SWD idle, radio NSS/RESET and RF switch default states against manufacturer reference circuits.
- [ ] Isolate subsystem supplies with current-rated links and measure current; prevent GPIO backfeed.
- [ ] Select actual connector footprints, mechanical clearance and SMA reinforcement; verify USB plug and SMA against PCB thickness.
- [ ] Complete physical schematic and routed PCB; ERC/DRC, schematic-PCB parity, RF review.
- [ ] Verify BOM, DNP variants, pick and place and fabrication outputs before approval.

Audit findings remain open until physical implementation and measured/automated verification. Functional blocks do not count as completed circuits.
