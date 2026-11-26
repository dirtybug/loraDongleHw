# Physical Component Libraries (`LoRa DualBand R2-DEV`)

All components in `KiCad/LoRa_DualBand.kicad_sch` and `KiCad/LoRa_DualBand.kicad_pcb` resolve against either:
1. Official KiCad 8/9/10 system libraries (`/usr/share/kicad/symbols`, `/usr/share/kicad/footprints`), or
2. Project-local verified custom libraries registered in `KiCad/sym-lib-table` and `KiCad/fp-lib-table`:
   - `KiCad/Libraries/LoRa_DualBand_Custom.kicad_sym`
   - `KiCad/Libraries/LoRa_DualBand_Custom.pretty/`

## Locked Active ICs, RF Modules, Filters & Connectors

| Reference | MPN | Package | Symbol ID | Footprint ID |
|---|---|---|---|---|
| **U1** | `FT4232HL` | LQFP-64 | `Interface_USB:FT4232H` | `Package_QFP:LQFP-64_10x10mm_P0.5mm` |
| **U2** | `STM32G0B1RET6` | LQFP-64 | `MCU_ST_STM32G0:STM32G0B1RETx` | `Package_QFP:LQFP-64_10x10mm_P0.5mm` |
| **U3** | `E22-400M22S` (SX1268, 433 MHz) | 14×20 mm SMD | `LoRa_DualBand_Custom:E22-400M22S` | `LoRa_DualBand_Custom:Ebyte_E22-M22S_14x20mm` |
| **U4** | `E22-900M22S` (SX1262, 868 MHz) | 14×20 mm SMD | `LoRa_DualBand_Custom:E22-900M22S` | `LoRa_DualBand_Custom:Ebyte_E22-M22S_14x20mm` |
| **U5** | `TPS562201DDCR` (3.3 V 2 A Buck) | SOT-23-6 | `LoRa_DualBand_Custom:TPS562201` | `Package_TO_SOT_SMD:SOT-23-6` |
| **U6** | `USB2422-I/MJ` (USB 2.0 HS Hub) | SQFN-24-1EP | `LoRa_DualBand_Custom:USB2422` | `Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm` |
| **U7** | `STM32U073CCT6` (Onboard Probe) | LQFP-48 | `LoRa_DualBand_Custom:STM32U073CCT6` | `Package_QFP:LQFP-48_7x7mm_P0.5mm` |
| **U8, U11** | `SN74CB3Q3126PWR` (Quad FET Bus Switch, `Ioff`) | TSSOP-14 | `LoRa_DualBand_Custom:SN74CB3Q3126` | `Package_SO:TSSOP-14_4.4x5mm_P0.65mm` |
| **U9** | `TPS22918DBVR` (2 A Load Switch) | SOT-23-6 | `LoRa_DualBand_Custom:TPS22918` | `Package_TO_SOT_SMD:SOT-23-6` |
| **U10** | `TPS2121RUXR` (4.5 A Power Mux, DNP Basic) | VQFN-HR-12 | `LoRa_DualBand_Custom:TPS2121RUXR` | `LoRa_DualBand_Custom:TI_VQFN-HR-12_2.0x2.5mm_RUX` |
| **U12** | `93LC56BT-I/SN` (FT4232HL EEPROM) | SOIC-8 | `Memory_EEPROM:93LCxxC` | `Package_SO:SOIC-8_3.9x4.9mm_P1.27mm` |
| **U13** | `TPS3839K33DBZR` (2.93 V 200 ms Delayed PG Supervisor) | SOT-23-3 | `LoRa_DualBand_Custom:TPS3839K33` | `Package_TO_SOT_SMD:SOT-23` |
| **FL1** | `LFCN-490+` (433 MHz LTCC LPF, 8.5 W) | FV1206 | `LoRa_DualBand_Custom:MiniCircuits_FV1206_Filter` | `Filter:Filter_Mini-Circuits_FV1206` |
| **FL2** | `HFCN-740+` (868 MHz LTCC HPF, 7 W, >40 dB @ 433 MHz) | FV1206 | `LoRa_DualBand_Custom:MiniCircuits_FV1206_Filter` | `Filter:Filter_Mini-Circuits_FV1206` |
| **FL3** | `LFCN-900+` (868 MHz LTCC LPF, 10 W, >30 dB @ 1736 MHz) | FV1206 | `LoRa_DualBand_Custom:MiniCircuits_FV1206_Filter` | `Filter:Filter_Mini-Circuits_FV1206` |
| **D1** | `USBLC6-2SC6` (USB HS ESD <1 pF) | SOT-23-6 | `Power_Protection:USBLC6-2SC6` | `Package_TO_SOT_SMD:SOT-23-6` |
| **D2, D3** | `SMAJ5.0A` (5 V VBUS TVS) | SMA | `Device:D_TVS` | `Diode_SMD:D_SMA` |
| **L1** | `IHLP1616ABER3R3M01` (3.3 µH 3.5 A shielded) | 4040 | `Device:L` | `Inductor_SMD:L_Vishay_IHLP-1616` |
| **Y1/Y2/Y3** | `ABM8G` 12 / 24 / 16 MHz | 3225 4-pin | `Device:Crystal_GND24` | `Crystal:Crystal_SMD_3225-4Pin_3.2x2.5mm` |
| **J1** | `DX07P024AJ1` (JAE USB-C Male Plug 1.6 mm) | USB-C Plug | `Connector:USB_C_Plug_USB2.0` | `Connector_USB:USB_C_Plug_JAE_DX07P024AJ1` |
| **J2, J3** | `132289` (Amphenol SMA 50 Ω Edge-Launch, opposite edges) | SMA-Edge | `Connector:Conn_Coaxial` | `Connector_Coaxial:SMA_Amphenol_132289_EdgeMount` |
| **J4** | `FTSH-105-01-L-DV-K` (Cortex Debug 10-pin 1.27 mm) | 2×5 SMD | `Connector_Generic:Conn_02x05_Odd_Even` | `Connector_PinHeader_1.27mm:PinHeader_2x05_P1.27mm_Vertical_SMD` |
| **J5, J7** | `61300211121` / `61300511121` (Wurth 2.54 mm headers) | 1×2 / 1×5 THT | `Connector_Generic:Conn_01x02` / `Conn_01x05` | `Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical` / `1x05` |
| **J6** | `TYPE-C-31-M-12` (HRO Aux USB-C 5 V, DNP Basic) | USB-C 16P | `Connector:USB_C_Receptacle_USB2.0_16P` | `Connector_USB:USB_C_Receptacle_HRO_TYPE-C-31-M-12` |

## Verification

Run `python3 ci/check_libraries.py` inside the KiCad CI container to confirm 0 missing or unresolved entries across all 210 physical components in `KiCad/Libraries/components.csv`.
