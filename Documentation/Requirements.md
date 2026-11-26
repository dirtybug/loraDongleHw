# R2 hardware requirements (draft)
- STM32G0B1RET6, four independent USARTs with RTS/CTS and DMA, fifth USART for debug logs, two SPI buses; pin mux pending.
- FT4232H quad UART: A shared AT control, B 433 MHz data, C 868 MHz data, D selectable native mesh protocol. STM32F072CBT6 UART bridge for logs. EEPROM configuration to validate.
- Two SX1262 TCXO modules, 433 MHz and 868 MHz, independent 50 ohm SMA female connectors.
- USB-C male with extended narrow neck for phone cases; preliminary board 90 x 35 mm, four layers.
- USB2422 hub and STM32F072CBT6 CMSIS-DAP onboard debugger; external SWD isolation; U7 has 128 KB internal Flash and requires its own programming SWD access and BOOT0 bias. CMSIS-DAP plus CDC firmware port must be validated.
- Optional USB-C auxiliary 5 V input, TPS2121 power mux, mutually exclusive solder bypass, inrush and reverse-current protection. Basic and Full assembly variants.
- Optional bulk capacitor after current limiting; verify USB power budget and all supply rails.
- Test points on both sides of 0603 zero-ohm isolation links for UART, SPI, BUSY, DIO1 and RESET; SWD access and ground points.
- Separate power isolation links and current measurement points per subsystem; prevent GPIO backfeed.
- No conventional stubs on RF or USB HS differential traces.
- Validate pin multiplexing, RF harmonics/coexistence, antenna match, power and mechanical strength.
- Firmware and Android belong to separate repositories. Target Keil RTX5.
- Original reference: https://github.com/Ropixon/AT-LoRa-USB-Dongle (do not redistribute original design without verified permission).
- No fabrication approval until complete schematic, real footprints, routing, ERC/DRC and engineering review. Variant-specific BOM/CPL generation still needs implementation.

- Shared control commands explicitly identify target radio (433/868 or ALL where meaningful); serialize per-radio state transitions and arbitrate raw/native mesh ownership. No debug text on binary ports.

- Debugger default OFF: R11 10k pull-down on DEBUG_EN. J5 enables by connecting 3V3 to DEBUG_EN; U9 must enable high; U8/U11 must remain isolated until debugger power is valid and disable before power removal. Invert active-low OE as needed, and verify powered-off leakage and startup/shutdown sequencing. Logical enable wiring is not a validated physical isolation circuit.
