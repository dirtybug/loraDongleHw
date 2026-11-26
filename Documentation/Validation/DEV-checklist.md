# Checklist de Engenharia — Versão DEV (`LoRa DualBand R2-DEV`)

> **Objetivo:** Validar integralmente a revisão **DEV** (protótipo de desenvolvimento/bancada) antes de gerar Gerbers, BOM e Pick-and-Place para fabrico.  
> **Regra de ouro:** Nenhum item passa por suposição — cada caixa `[x]` corresponde a verificação direta no esquemático nativo (`KiCad/LoRa_DualBand.kicad_sch`), PCB (`KiCad/LoRa_DualBand.kicad_pcb`), biblioteca (`KiCad/Libraries/LoRa_DualBand_Custom.*`), datasheet oficial ou ensaio de bancada.  
> **Última auditoria:** Revisão **R2-DEV completa em KiCad 8 nativo** — `222` símbolos (`210` componentes físicos + `12` `PWR_FLAG`), `0` TBD na BOM (`59` linhas), `0` erros ERC internos, `0` sobreposições de courtyard na PCB 4 camadas, filtros RF dedicados (`FL1` `LFCN-490+` + `FL2` `HFCN-740+` + `FL3` `LFCN-900+`), SMAs em arestas opostas (`J2` topo / `J3` fundo), e `85.6%` (`267/312`) dos pares de sinal + `98.4%` (`190/193`) vias de plano auto-roteados (restam `45` pares para acabamento manual no KiCad PCB Editor).

---

## 1. Tamanhos dos ICs, Footprints, Pinout Físico e Anti-Mirror

### 1.1 Tabela de Dimensões Físicas e Footprints Obrigatórios (Todos os MPNs Fechados)

| Ref | Componente / MPN | Package | Corpo (mm) | Span c/ Pinos (mm) | Courtyard mín. (mm) | Pitch (mm) | Footprint KiCad / Projeto | Verificado |
|---|---|---|---|---|---|---|---|---|
| **U1** | `FT4232HL` | LQFP-64 | `10.0 × 10.0` | `12.0 × 12.0` | `~13.1 × 13.1` | `0.50` | `Package_QFP:LQFP-64_10x10mm_P0.5mm` | [x] |
| **U2** | `STM32G0B1RET6` | LQFP-64 | `10.0 × 10.0` | `12.0 × 12.0` | `~13.1 × 13.1` | `0.50` | `Package_QFP:LQFP-64_10x10mm_P0.5mm` | [x] |
| **U3** | `E22-400M22S` (433 MHz, SX1268) | SMD Castellated | `20.0 × 14.0` | `20.0 × 14.0` | `~21.0 × 15.0` | `1.27` | `LoRa_DualBand_Custom:Ebyte_E22-M22S_14x20mm` (Top View) | [x] |
| **U4** | `E22-900M22S` (868 MHz, SX1262) | SMD Castellated | `20.0 × 14.0` | `20.0 × 14.0` | `~21.0 × 15.0` | `1.27` | `LoRa_DualBand_Custom:Ebyte_E22-M22S_14x20mm` (Top View) | [x] |
| **U5** | `TPS562201DDCR` (Buck `3.3 V / 2 A`) | SOT-23-6 | `2.9 × 1.6` | `2.9 × 2.8` | `~3.4 × 3.4` | `0.95` | `Package_TO_SOT_SMD:SOT-23-6` (+ `L1` `IHLP1616ABER3R3M01`) | [x] |
| **U6** | `USB2422-I/MJ` | SQFN-24-1EP | `4.0 × 4.0` | `4.0 × 4.0` | `~4.8 × 4.8` | `0.50` | `Package_DFN_QFN:QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm` | [x] |
| **U7** | `STM32U073CCT6` | LQFP-48 | `7.0 × 7.0` | `9.0 × 9.0` | `~10.1 × 10.1` | `0.50` | `Package_QFP:LQFP-48_7x7mm_P0.5mm` | [x] |
| **U8** | `SN74CB3Q3126PWR` (SWD Switch `Ioff`) | TSSOP-14 | `5.0 × 4.4` | `5.0 × 6.4` | `~5.8 × 7.0` | `0.65` | `Package_SO:TSSOP-14_4.4x5mm_P0.65mm` | [x] |
| **U9** | `TPS22918DBVR` (Load Switch `2 A`) | SOT-23-6 | `2.9 × 1.6` | `2.9 × 2.8` | `~3.4 × 3.4` | `0.95` | `Package_TO_SOT_SMD:SOT-23-6` | [x] |
| **U10** | `TPS2121RUXR` (Power Mux, DNP Basic) | VQFN-HR-12 (`RUX`) | `2.0 × 2.5` | `2.0 × 2.5` | `~2.8 × 3.3` | `0.40/0.50` | `LoRa_DualBand_Custom:TI_VQFN-HR-12_2.0x2.5mm_RUX` | [x] *(rever contra TI RUX0012A em KiCad)* |
| **U11** | `SN74CB3Q3126PWR` (UART Switch `Ioff`) | TSSOP-14 | `5.0 × 4.4` | `5.0 × 6.4` | `~5.8 × 7.0` | `0.65` | `Package_SO:TSSOP-14_4.4x5mm_P0.65mm` | [x] |
| **U12** | `93LC56BT-I/SN` (EEPROM FT4232HL) | SOIC-8 | `4.9 × 3.9` | `4.9 × 6.0` | `~5.6 × 6.6` | `1.27` | `Package_SO:SOIC-8_3.9x4.9mm_P1.27mm` | [x] |
| **FL1** | `LFCN-490+` (433 MHz LPF, 8.5 W) | FV1206 LTCC | `3.2 × 1.6` | `3.2 × 1.6` | `~4.3 × 3.1` | — | `Filter:Filter_Mini-Circuits_FV1206` | [x] |
| **FL2, FL3** | `HFCN-740+` (HPF 7 W) + `LFCN-900+` (LPF 10 W) | FV1206 LTCC | `3.2 × 1.6` | `3.2 × 1.6` | `~4.3 × 3.1` | — | `Filter:Filter_Mini-Circuits_FV1206` (BPF 780–900 MHz bidirecional) | [x] |
| **Y1/Y2/Y3** | `ABM8G` `12 / 24 / 16 MHz` | SMD 4-pin (`3225`) | `3.2 × 2.5` | `3.2 × 2.5` | `+0.5 mm` | — | `Crystal:Crystal_SMD_3225-4Pin_3.2x2.5mm` | [x] |
| **D1** | `USBLC6-2SC6` (ESD USB HS `<1 pF`) | SOT-23-6 | `2.9 × 1.6` | `2.9 × 2.8` | `~3.4 × 3.4` | `0.95` | `Package_TO_SOT_SMD:SOT-23-6` | [x] |
| **D2, D3** | `SMAJ5.0A` (TVS 5 V VBUS) | SMA | `4.5 × 2.6` | `5.2 × 2.6` | `~6.0 × 3.2` | — | `Diode_SMD:D_SMA` | [x] |
| **J1** | `DX07P024AJ1` (JAE USB-C Macho) | Straddle SMT | Shell `8.25 mm` | — | Cutout `1.6 mm` | `0.50` | `Connector_USB:USB_C_Plug_JAE_DX07P024AJ1` | [x] |
| **J2, J3** | `132289` (Amphenol SMA `50 Ω`) | Edge-Launch `1.6 mm` | Corpo `~9.5 mm` | — | **Arestas opostas** | — | `Connector_Coaxial:SMA_Amphenol_132289_EdgeMount` | [x] |
| **J4** | `FTSH-105-01-L-DV-K` (Cortex 10p) | 2×5 1.27 mm SMD | `~7.6 × 5.1` | — | `~8.6 × 6.1` | `1.27` | `Connector_PinHeader_1.27mm:PinHeader_2x05_P1.27mm_Vertical_SMD` | [x] |
| **J5** | `61300211121` (Jumper `DEBUG_EN`) | Header 1×2 THT | `5.08 × 2.54` | — | — | `2.54` | `Connector_PinHeader_2.54mm:PinHeader_1x02_P2.54mm_Vertical` | [x] |
| **J6** | `TYPE-C-31-M-12` (Aux 5 V, DNP Basic) | USB-C 16P | `~8.9 × 7.3` | — | Folga borda PCB | `0.50` | `Connector_USB:USB_C_Receptacle_HRO_TYPE-C-31-M-12` | [x] |
| **J7** | `61300511121` (SWD Probe `U7`) | Header 1×5 THT | `12.7 × 2.54` | — | Fora de RF/USB | `2.54` | `Connector_PinHeader_2.54mm:PinHeader_1x05_P2.54mm_Vertical` | [x] |

### 1.2 Verificação Anti-Mirror e Mecânica
- [x] **Numeração anti-horária em Top View (`F.Cu`)** confirmada em todos os QFP/QFN (`U1`, `U2`, `U6`, `U7`, `U10`) usando footprints oficiais KiCad e land pattern `TI_VQFN-HR-12_2.0x2.5mm_RUX`.
- [x] **Módulos RF `U3`/`U4` (`E22`)**: 22 pinos (incluindo gap de `5.588 mm` entre pinos 3–4 e 19–20) e pino 21 (`ANT`) conferidos em vista de topo (*Top View*).
- [x] **USB-C Macho (`J1`)**: `Connector_USB:USB_C_Plug_JAE_DX07P024AJ1` (plug macho oficial KiCad) com `CC` apenas em `A5` (`R1 = 5.1 kΩ`) e `D+/D-` em `A6/A7`.
- [ ] **Exposed Pads (`EP`)** em `U6` (`USB2422`) e `U10` (`TPS2121RUXR`): confirmar no KiCad PCB Editor a segmentação da pasta (`50–70%`) e adicionar vias térmicas dedicadas sob `U6` pad 25.
- [x] **Espessura do PCB (`1.6 mm`)** configurada no stackup e compatível com `J1` (`DX07P024AJ1`) e `J2`/`J3` (`Amphenol 132289`).
- [x] **Margens mecânicas & SMAs em lados opostos**: `0` sobreposições de courtyard (`OVERLAPS = 0`); `J2` (433 MHz) na borda **superior** (`Y = 50.0 mm`, apontando para cima) e `J3` (868 MHz) na borda **inferior** (`Y = 85.0 mm`, apontando para baixo) — **`35 mm` de separação entre arestas opostas**, permitindo antenas articuladas a `90°`/polarização cruzada!
- [ ] **Marcadores de Pino 1** na serigrafia (`F.SilkS`): inspecionar visualmente no KiCad que nenhum marcador fica tapado após montagem.

---

## 2. Pull-Ups, Pull-Downs e Resistências Obrigatórias por Bus / IC

### 2.1 USB & Power Mux
- [x] **`J1` (USB-C Macho)**: `R1 = 5.1 kΩ` em `CC (A5) → GND`.
- [x] **`J6` (USB-C Auxiliar Fêmea, DNP Basic)**: **2× `5.1 kΩ` independentes** (`R2` em `CC1_EXT → GND`, `R3` em `CC2_EXT → GND`).
- [x] **`U6` (`USB2422-I/MJ`, DS00001692)**:
  - [x] `RBIAS` (pino 24): `R35 = 12.0 kΩ 1% → GND`.
  - [x] `RESET_N` (pino 15): `R38 = 10 kΩ → 3V3_HUB` + `C32 = 1 µF → GND`.
  - [x] `VBUS_DET` (pino 16): divisor `R36 = 100 kΩ / R37 = 100 kΩ` (`VBUS → ~2.5 V`).
  - [x] `OCS1_N` (pino 8) e `OCS2_N` (pino 12): `R39 = 10 kΩ` e `R40 = 10 kΩ → 3V3_HUB`.
  - [x] Straps `NON_REM1` (`R41 = 10 kΩ → 3V3_HUB`), `CFG_SEL0` (`R42 = 10 kΩ → GND`), `SUSP_IND` (`R43 = 10 kΩ → GND`, ligado a `U2 PC13`).
- [x] **`U1` (`FT4232HL`)**:
  - [x] `REF` (pino 6): `R44 = 12.0 kΩ 1% → GND`.
  - [x] `RESET#` (pino 14): `R45 = 10 kΩ → 3V3_FTDI` + `C42 = 100 nF → GND`.
  - [x] `TEST` (pino 13): ligado diretamente a `GND`.
  - [x] EEPROM `U12` (`93LC56BT-I/SN`): pull-ups `R47/R48/R49 = 10 kΩ` em `EECS/EECLK/EEDATA` + `R46 = 2.2 kΩ` série em `EEDATA↔DO`.
- [x] **`U10` (`TPS2121RUXR`, DNP Basic)**:
  - [x] Divisores `PR1` (`R20=100k/R21=33.2k`), `CP2` (`R22=100k/R23=33.2k`), `OV1` (`R24=100k/R25=24.9k`, OVLO ~5.9 V), `OV2` (`R26=100k/R27=24.9k`, OVLO ~5.9 V).
  - [x] `ILM` (`R28 = 15 kΩ → GND`, limite `~1.5 A`) + soft-start `SS` (`C20 = 22 nF → GND`).
  - [x] `ST` (pino 9, open-drain): `R29 = 100 kΩ → 3V3` ligado a `U2 PC0 (PWR_SRC_ST)`.

### 2.2 MCU Target (`U2` — `STM32G0B1RET6`) e Buses Periféricos
- [x] **`BOOT0` (`PA14-BOOT0`, pino 46 — partilhado com `SWCLK` no `STM32G0B1RET6`!)**: corrigido face à nota antiga `PB8-BOOT0`! `R10 = 10 kΩ` pull-down → `GND` em `SWCLK / PA14-BOOT0` garante boot pela Flash em MCU virgem e clock SWD estável.
- [x] **`NRST` (`PF2`, pino 12)**: `R4 = 10 kΩ` pull-up → `3V3_MCU` + `C2 = 100 nF` → `GND`.
- [x] **SPI1 (`U3` 433 MHz) & SPI2 (`U4` 868 MHz)**:
  - [x] `A_NSS` e `B_NSS`: `R5`, `R6 = 10 kΩ` pull-up → `3V3_RF433` / `3V3_RF868`.
  - [x] `A_RESET` e `B_RESET`: `R7`, `R8 = 10 kΩ` pull-up → `3V3_RF433` / `3V3_RF868`.
  - [x] `A_RXEN`, `A_TXEN`, `B_RXEN`, `B_TXEN`: **`R54..R57 = 100 kΩ` pull-down → `GND`** (garante RF switch OFF durante reset/boot).
  - [x] Todos os 18 sinais SPI/CTRL passam por resistências `0 Ω` 0603 (`R121..R129`, `R131..R139`, substituíveis por `22–33 Ω` se necessário para EMI).
- [x] **5× UARTs (`CTRL`, `DATA433`, `DATA868`, `MESH`, `LOG`)**:
  - [x] Todas as 18 linhas isoladas por `0 Ω` 0603 (`R101..R118`).
  - [x] `M_LOG_TX` / `M_LOG_RX`: `R50 = 100 kΩ` pull-up → `3V3_MCU` evita flutuação quando `U11` está em Hi-Z.
- [x] **Bus SWD Target (`SWDIO`, `SWCLK`)**: `R9 = 10 kΩ` pull-up em `SWDIO`, `R10 = 10 kΩ` pull-down em `SWCLK / PA14-BOOT0`.

### 2.3 Debugger (`U7` — `STM32U073CCT6`) e Isolamento (`U8`, `U9`, `U11`, `J5`)
- [x] **`DEBUG_EN`**: `R11 = 10 kΩ` pull-down → `GND` (default = Debugger OFF).
- [x] **`J5` (`3V3` → `DEBUG_EN`)**: `R52 = 1 kΩ` em série no lado `3V3` para proteção contra curto acidental.
- [x] **`PROBE_BOOT0` (`PF3-BOOT0`, pino 44)**: `R13 = 10 kΩ` pull-down → `GND`.
- [x] **`PROBE_NRST` (`PF2-NRST`, pino 7)**: `C3 = 100 nF` → `GND`.
- [x] **`U8`, `U9`, `U11` polaridade de Enable**: TODOS ativos-ALTO (`TPS22918 ON`, `SN74CB3Q3126 1OE..4OE`), diretamente comandados por `DEBUG_EN` sem inversor!

---

## 3. Condensadores de Desacoplamento (Decoupling) e Bulk Junto aos ICs

- [x] **`U1` (`FT4232HL`)**: `FB3`/`FB4` (`BLM18PG601SN1D`) + `C43..C46` (`4.7 µF + 100 nF` em `VPHY` e `VPLL`), `C47..C50` (`4.7 µF + 3× 100 nF` em `VCORE`), `C51..C55` (`4.7 µF + 4× 100 nF` em `3V3_FTDI`), `C56` (`100 nF` em `U12`).
- [x] **`U2` (`STM32G0B1RET6`)**: `C59` (`100 nF`), `C60` (`1 µF` `VREF+`), `C61` (`4.7 µF` bulk) + `C57`/`C58` (`18 pF C0G` no cristal `16 MHz` `Y3`).
- [x] **`U3` (`E22-400M22S`) & `U4` (`E22-900M22S`)**: `C70`/`C72` (`22 µF` 0805 X5R `GRM21BR61A226ME44L`) + `C71`/`C73` (`100 nF`) atrás de `FB1`/`FB2` (`BLM21PG601SN1D`).
- [x] **`U5` (`TPS562201DDCR`)**: `C24` (`10 µF` 0805 16 V) + `C25` (`100 nF`) em `SYS_5V`, `C23` (`100 nF` `VBST`), `C26`/`C27` (`2× 22 µF` 0805) + `C28` (`100 nF`) em `U5_3V3_OUT`.
- [x] **`U6` (`USB2422-I/MJ`)**: `C35..C37` (`3× 100 nF`) + `C38` (`4.7 µF`) em `3V3_HUB`, `C33` (`1 µF` `CRFILT`), `C34` (`1 µF` `PLLFILT`), `C30`/`C31` (`18 pF C0G` no `24 MHz` `Y2`).
- [x] **`U7` (`STM32U073CCT6`)**: `C4..C10` (`5× 100 nF` + `1 µF` `VDDA` + `4.7 µF` bulk) colocados na `B.Cu` imediatamente sob `U7`.
- [x] **`U8`, `U9`, `U11`**: `C65`/`C66` (`100 nF`), `C63`/`C64` (`1 µF` `VIN`/`VOUT` de `U9`), `C62` (`1 nF` `CT` soft-start de `U9`).
- [x] **`U10` (`TPS2121RUXR`) & `VBUS`/`SYS_5V`**: `C21 = 4.7 µF` em `VBUS` (`≤ 10 µF` USB spec!); `C22 = 4.7 µF` em `VBUS_EXT` (DNP Basic); **`C1A` + `C1B` (`2× 220 µF` 1210 `GRM32ER60J227ME05L` = `440 µF`, DNP Basic / Fit Full)** exclusivamente em `SYS_5V` após soft-start/ILIM de `U10`!

---

## 4. Verificação de Pinos e Suporte de Buses (AF / Pin Mux / DMA)

### 4.1 `U2` (`STM32G0B1RET6` — LQFP-64)
- [x] **4× USARTs com Hardware Flow Control (`TX/RX/RTS/CTS`)** mapeados sem conflito:
  - `CTRL`: `USART1` (`PB6/PB7/PB3/PB4`)
  - `DATA433`: `USART2` (`PA2/PA3/PA1/PA0`)
  - `DATA868`: `USART3` (`PB10/PB11/PB14/PB13`)
  - `MESH`: `USART5` (`PD3/PD2/PD4/PD5`)
- [x] **5.ª UART (`LOG`)**: `LPUART2` (`PC6/PC7`).
- [x] **2× SPIs independentes + Controlos RF sem conflitos EXTI**:
  - `SPI1` (433 MHz): `PA5/PA6/PA7/PA4` + `PC4 (BUSY)`, `PC5 (EXTI5 IRQ)`, `PB0 (RESET)`, `PB1 (RXEN)`, `PB2 (TXEN)`.
  - `SPI2` (868 MHz): `PD1/PC2/PC3/PD0` + `PD8 (BUSY)`, `PD9 (EXTI9 IRQ)`, `PC8 (RESET)`, `PC9 (RXEN)`, `PC10 (TXEN)`.
- [x] **Sinais de Sistema & HSE**: `PC0 = PWR_SRC_ST`, `PC1 = USB_PWREN_N`, `PC13 = USB_SUSP`, `PB8 = MCU_LED`, `PF0/PF1 = 16 MHz HSE (Y3)`.
- [ ] **Validação final no STM32CubeMX**: confirmar `DMAMUX` (12 canais DMA1+DMA2) para os 4× USARTs + 2× SPIs + gestor de coexistência RF.

### 4.2 `U1`, `U7`, `U8`, `U11`
- [x] `U1` (`FT4232HL`): 4 canais UART + RTS/CTS ligados a `U2` via `R101..R116`, `HUB1_DP/DM` corretos (pinos 8/7).
- [x] `U7` (`STM32U073CCT6`): 48/48 pinos verificados contra `DS14548`.
- [x] `U8`/`U11` (`SN74CB3Q3126PWR`): FET bus switches bidirecionais com `Ioff` parcial (suportam `SWDIO`/`NRST` bidirecionais e bloqueiam backfeed quando `DEBUG_EN = 0`).
- [ ] Validar em firmware `U7` o bit `USV` (`VDDUSB`) e sincronização `HSI48 + CRS` com o SOF do `USB2422`.

---

## 5. Regras de EMC, Integridade de Sinal, USB-HS e Coexistência RF (PCB 4 Camadas)

### 5.1 Stackup e Planos de Referência
- [x] **Stackup 4 camadas `1.6 mm` ENIG** definido na PCB: `F.Cu` (`35 µm`, sinais/RF/USB) / `0.21 mm` prepreg / `In1.Cu` (**plano `GND` contínuo e sólido sem splits!**) / `1.065 mm` core / `In2.Cu` (zona `3V3` digital + zona **`GND` contínua sob toda a área RF `X ≥ 108.5 mm`**) / `0.21 mm` prepreg / `B.Cu` (`35 µm`, passivos + sinais secundários).

### 5.2 USB 2.0 High-Speed (`480 Mbps`) e Full-Speed
- [x] **ESD flow-through `D1` (`USBLC6-2SC6`, `<1 pF`)** colocado imediatamente à saída de `J1`; zero stubs e zero `0 Ω` nos pares USB.
- [ ] **Afinação final em KiCad PCB Editor**: ajustar largura/espaçamento exato de `90 Ω ±10%` e *length matching* (`≤ 0.15 mm`) em `USB_DP/DM`, `HUB1_DP/DM` e `HUB2_DP/DM` (concluir manualmente `HUB1_DP` e `HUB2_DM` dos 45 pares pendentes).

### 5.3 Coexistência RF `433 MHz` ↔ `868 MHz`, Filtragem Harmónica e Layout de Antenas
> **Análise física dos 3 riscos críticos numa PCB de `~90 × 35 mm`** (onde `λ/4 = 17.3 cm @ 433 MHz` e `8.6 cm @ 868 MHz`, impossibilitando isolamento apenas por distância):
> 1. **Acoplamento entre antenas** (parte da potência TX de uma antena acopla diretamente na outra);
> 2. **Saturação do recetor (LNA)** (mesmo fora de banda, `+22 dBm` em 433 MHz pode saturar o front-end de 868 MHz);
> 3. **2.ª Harmónica de 433 MHz (`2 × 433.92 = 867.84 MHz` / `433 × 2 = 866 MHz`)** — cai diretamente dentro da banda de 868 MHz!

- [x] **Filtragem RF 433 MHz (`FL1` = Mini-Circuits `LFCN-490+`, LTCC `FV1206`, `8.5 W / +39 dBm`)**: filtro passa-baixo `DC–490 MHz` (`IL ≤ 1.2 dB @ 433 MHz`) que atenua a **2.ª harmónica em 866–868 MHz em `~35–40 dB`** (e `≥ 40 dB` em `880–2500 MHz`).
- [x] **Filtragem RF 868 MHz (`FL2` `HFCN-740+` + `FL3` `LFCN-900+`, LTCC `FV1206`, `7 W / +38.5 dBm`)**: **filtro passa-banda (BPF) bidirecional `780–900 MHz`** capaz de suportar `+22 dBm TX` com enorme margem térmica (ao contrário de filtros SAW comuns limitados a `+10..+15 dBm`!), oferecendo **`≥ 40 dB` de rejeição em `433 MHz`** (protege o recetor contra saturação) e **`≥ 30–35 dB` na 2.ª harmónica em `1736 MHz`**!
- [x] **Conectores SMA em lados opostos da placa**: `J2` (`433 MHz`) montado na aresta **superior (`Y = 50 mm`)** e `J3` (`868 MHz`) montado na aresta **inferior (`Y = 85 mm`)** — prontos para **antenas articuladas a `90°`** (polarização cruzada ortogonal).
- [x] **Separação física + Via Stitching GND + Pistas RF `50 Ω` na `F.Cu`**: `U3` e `U4` separados por corredor com cerca contínua de vias GND (`Y = 67.5 mm`, passo `2.2 mm`), `In1.Cu` e `In2.Cu` em `GND` sólido sob toda a zona RF, todas as 7 nets RF (`RF_A_MOD → FL1 → R_RF_A → J2`, `RF_B_MOD → FL2 → FL3 → R_RF_B → J3`) 100% roteadas em `F.Cu` (`0.35 mm`, sem vias de sinal).
- [x] **Filtragem da alimentação RF**: `FB1` e `FB2` (`BLM21PG601SN1D`, `600 Ω @ 100 MHz`, `2 A`) + `22 µF` + `100 nF` em `U3` e `U4`.
- [ ] **Afinação CPWG `50 Ω` e medição VNA/Espectro**: ajustar largura exata de `50 Ω` para o prepreg final do fabricante (PCBWay), adicionar vias de guarda ao longo das pistas RF em KiCad e medir isolamento `S21` entre `J2` e `J3` e conformidade ETSI EN 300 220 em laboratório.
- [ ] **Proteção adicional por Firmware — Gestor de Coexistência RF no `STM32G0B1RET6` (`U2`)**:
  Implementar inicialmente a política conservadora abaixo até validar em laboratório o isolamento real entre antenas e a dessensibilização do recetor:

  | Rádio 433 MHz (`U3`) | Rádio 868 MHz (`U4`) | Política Inicial de Firmware |
  |---|---|---|
  | `RX` | `RX` | **Permitir** |
  | `TX` | `RX` | **Bloquear temporariamente `RX` (868)** |
  | `RX` | `TX` | **Bloquear temporariamente `RX` (433)** |
  | `TX` | `TX` | **Bloquear** *(evita também pico duplo de corrente USB OTG)* |

### 5.4 Cristais, Buck (`U5`) e ESD Geral
- [x] `Y1` (`12 MHz`), `Y2` (`24 MHz`), `Y3` (`16 MHz`) com condensadores `C0G/NP0` (`18 pF`).
- [x] Buck `U5` (`TPS562201DDCR`, `4.5–17 V` max in) + indutor blindado `L1` (`IHLP1616ABER3R3M01`) afastado da zona RF + TVS `D2`/`D3` (`SMAJ5.0A`) em `VBUS`/`VBUS_EXT` contra *hot-plug ringing*.
- [ ] **Refinamento em KiCad**: otimizar áreas de polígono de cobre curto no nó `SW` de `U5` e manter anel GND limpo sob `Y1`/`Y2`/`Y3`.

---

## 6. Cálculos de Potência e Orçamento Energético por Fonte

- [x] **Orçamento calculado e verificado**:
  - RX Dual (dbg OFF): `I_3V3 ≈ 135 mA` → `I_5V ≈ 116 mA` (@ 4.5 V, η=85%).
  - 1× TX `+22 dBm` + 1× RX: `I_3V3 ≈ 275 mA` → `I_5V ≈ 237 mA`.
  - Pior caso 2× TX `+22 dBm` simultâneo + Debugger ON: `I_3V3 ≈ 440 mA` (`1.45 W`) → `I_5V ≈ 380–450 mA`.
- [x] **Buck `U5` (`TPS562201DDCR`)**: `2.0 A` contínuos (>4× margem), síncrono, entrada `4.5–17 V` (resiste a picos USB hot-plug!).
- [x] **Power Mux `U10` (`TPS2121RUXR`, DNP Basic)**: `4.5 A`, `R_ON ≈ 56 mΩ`, `ILM = 15 kΩ (~1.5 A)`, `OVLO ≈ 5.9 V`, bloqueio de corrente reversa entre `J1` e `J6`.
- [x] **Load Switch `U9` (`TPS22918DBVR`)**: `2 A`, soft-start com `C62 = 1 nF` + QOD (descarga rápida ao desligar `J5`).
- [ ] Validar em bancada que o firmware só autoriza TX RF após `USB_PWREN_N = 0` / `USB_SUSP = 0` e respeita a política de coexistência (`TX+TX` bloqueado quando alimentado apenas por OTG sem `J6`).

---

## 7. Desativar Qualquer Componente via Resistência `0 Ω` (Isolamento de Alimentação)

| Link `0 Ω` / Ferrite | Rail Isolado | Bloco Desativado | Package | Test Points | Verificado |
|---|---|---|---|---|---|
| `R_PWR_3V3` | `U5_3V3_OUT → 3V3` | Buck `U5` em vazio | `0805` | `TP3` / `TP4` | [x] |
| `R_PWR_U6` | `3V3 → 3V3_HUB` | `U6` (`USB2422`) | `0603` | `TP4` / `TP5` | [x] |
| `R_PWR_U1` | `3V3 → 3V3_FTDI` | `U1` (`FT4232HL`) | `0603` | `TP4` / `TP6` | [x] |
| `R_PWR_U2` | `3V3 → 3V3_MCU` | `U2` (`STM32G0B1RET6`) | `0603` | `TP4` / `TP7` | [x] |
| `FB1` *(0805 removível)* | `3V3 → 3V3_RF433` | `U3` (`E22-400M22S`) | `0805` | `TP4` / `TP8` | [x] |
| `FB2` *(0805 removível)* | `3V3 → 3V3_RF868` | `U4` (`E22-900M22S`) | `0805` | `TP4` / `TP9` | [x] |
| `R_PWR_U7` | `DBG_3V3 → 3V3_PROBE` | `U7` (`STM32U073CCT6`) | `0603` | `TP10` / `TP11` | [x] |
| `SJ1` / `U10` | `VBUS → SYS_5V` | Bypass Basic vs Mux Full | SJ / VQFN-12 | `TP1` / `TP2` | [x] |

---

## 8. Desligar Ligações ao MCU (`U2`) com Resistências `0 Ω` (Isolamento de Sinais)

- [x] **FT4232H Canal A (`CTRL`) ↔ `U2`** (`R101..R104`, 4× `0 Ω` 0603).
- [x] **FT4232H Canal B (`DATA433`) ↔ `U2`** (`R105..R108`, 4× `0 Ω` 0603).
- [x] **FT4232H Canal C (`DATA868`) ↔ `U2`** (`R109..R112`, 4× `0 Ω` 0603).
- [x] **FT4232H Canal D (`MESH`) ↔ `U2`** (`R113..R116`, 4× `0 Ω` 0603).
- [x] **UART Logs (`U11`) ↔ `U2`** (`R117..R118`, 2× `0 Ω` 0603).
- [x] **Rádio 433 MHz (`U3`) ↔ `U2`** (`R121..R129`, 9× `0 Ω` 0603).
- [x] **Rádio 868 MHz (`U4`) ↔ `U2`** (`R131..R139`, 9× `0 Ω` 0603).
- [x] **4× Test Points `GND` distribuídos** (`TP13..TP16`) + `TP12` (`DEBUG_EN`).
- [x] **Exceções respeitadas**: ZERO `0 Ω` e ZERO stubs em `USB_DP/DM`, `HUB1_DP/DM`, `HUB2_DP/DM`; apenas `0402` inline (`R_RF_A`, `R_RF_B`) nas pistas RF `50 Ω`.

---

## 9. Usabilidade em Bancada DEV, DFM/Montagem e Bring-Up Seguro

- [x] **4× LEDs de estado**: `LED1` (Verde `3V3`), `LED2` (Âmbar `DBG_3V3`), `LED3` (Azul `MCU_LED`), `LED4` (Verde `PROBE_LED`).
- [x] **3× Fiduciais globais assimétricos** (`FID1..FID3`, `Ø 1.0 mm` / abertura `Ø 2.0 mm`).
- [x] **Serigrafia de bancada (`F.SilkS`)**: `LoRa DualBand R2-DEV`, `433 MHz LPF`, `868 MHz BPF`, `NO TX WITHOUT 50R LOAD`, `AUX 5V ONLY`, `DBG EN`.
- [ ] **Sequência de Bring-Up Seguro (na placa fabricada)**:
  - [ ] Passo 1: continuidade sem energia (`VBUS/SYS_5V/3V3/DBG_3V3 ↔ GND`).
  - [ ] Passo 2: fonte limitada a `100 mA`, remover `R_PWR_3V3`, validar `U5 = 3.31 V ±2%`.
  - [ ] Passo 3: ligar subsistemas 1 a 1 (`R_PWR_3V3 → R_PWR_U6 → R_PWR_U1 → R_PWR_U2 → J5/U7 → FB1/FB2` sempre com cargas `50 Ω` em `J2`/`J3`!).
  - [ ] Passo 4: teste de backfeed com `J5` aberto e `U2` ativo → `DBG_3V3 < 0.1 V`.
  - [ ] Passo 5: medição de isolamento RF (`S21` entre `J2` e `J3`), 2.ª harmónica 433→868 MHz e validação do gestor de coexistência RF.

---

## 10. Gate Final de Aprovação (Antes de Encomendar a Placa DEV)

- [x] Esquemático migrado para **KiCad 8 nativo (`KiCad/LoRa_DualBand.kicad_sch`)** — zero símbolos lógicos da cache v4.
- [x] `KiCad/Libraries/components.csv` (210 linhas) e `Manufacturing/BOM_PCBWay_DRAFT.csv` (59 linhas, 0 TBD) sincronizados 100% com o esquemático e a PCB.
- [ ] **Acabamento manual do roteamento no KiCad PCB Editor**: concluir os `45` pares de sinal pendentes (em particular `U6` QFN-24, `U10` VQFN-12, `SWDIO`/`SWCLK`/`NRST` e `HUB1_DP`/`HUB2_DM`) + afinação `90 Ω` USB / `50 Ω` RF + preencher zonas (`B`).
- [ ] Executar CI GitHub Actions (`ci/check_libraries.py` = `0`, `kicad-cli sch erc` = `0`, `kicad-cli pcb drc` = `0` erros e `0` unconnected items).
- [ ] Inspecionar visualmente PDFs (esquemático + PCB Top/Bottom) e rever rotações do ficheiro CPL no visualizador da PCBWay/JLCPCB antes de autorizar produção!
