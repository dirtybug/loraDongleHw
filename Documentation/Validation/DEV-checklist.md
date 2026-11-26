# Checklist de Engenharia — Versão DEV (`LoRa DualBand R2`)

> **Objetivo:** Validar integralmente a revisão **DEV** (protótipo de desenvolvimento/bancada) antes de gerar Gerbers, BOM e Pick-and-Place para fabrico.  
> **Regra de ouro:** Nenhum item passa por suposição — cada caixa `[x]` deve corresponder a verificação direta no esquemático nativo (`.kicad_sch`), PCB (`.kicad_pcb`), datasheet oficial e/ou STM32CubeMX.  
> **Última auditoria:** commit `ae31778` (bloco físico `U7` completo e ERC limpo; restantes blocos ainda em diagrama funcional e PCB com 0 footprints/pistas).

---

## 1. Tamanhos dos ICs, Footprints, Pinout Físico e Anti-Mirror

### 1.1 Tabela de Dimensões Físicas e Footprints Obrigatórios

| Ref | Componente / MPN | Package | Corpo (mm) | Span c/ Pinos (mm) | Courtyard mín. (mm) | Pitch (mm) | Footprint KiCad / Fabricante | Verificado |
|---|---|---|---|---|---|---|---|---|
| **U1** | `FT4232HL` | LQFP-64 | `10.0 × 10.0` | `12.0 × 12.0` | `~13.1 × 13.1` | `0.50` | `Package_QFP:LQFP-64_10x10mm_P0.5mm` | [ ] |
| **U2** | `STM32G0B1RET6` | LQFP-64 | `10.0 × 10.0` | `12.0 × 12.0` | `~13.1 × 13.1` | `0.50` | `Package_QFP:LQFP-64_10x10mm_P0.5mm` | [ ] |
| **U3** | `E22-400M22S` (433 MHz, SX1268) | SMD Castellated | `20.0 × 14.0` | `20.0 × 14.0` | `~21.0 × 15.0` | `1.27` | Land pattern oficial Ebyte (Top View!) | [ ] |
| **U4** | `E22-900M22S` (868 MHz, SX1262) | SMD Castellated | `20.0 × 14.0` | `20.0 × 14.0` | `~21.0 × 15.0` | `1.27` | Land pattern oficial Ebyte (Top View!) | [ ] |
| **U5** | Buck `3.3 V` (MPN TBD) | SOT-23-6 / WSON / QFN | *Confirmar MPN* | *Confirmar MPN* | *Confirmar MPN* | *Confirmar* | Datasheet fabricante (+ indutor blindado) | [ ] |
| **U6** | `USB2422` | SQFN-24-1EP | `4.0 × 4.0` | `4.0 × 4.0` | `~4.8 × 4.8` | `0.50` | `QFN-24-1EP_4x4mm_P0.5mm_EP2.6x2.6mm` (confirmar EP) | [ ] |
| **U7** | `STM32U073CCT6` | LQFP-48 | `7.0 × 7.0` | `9.0 × 9.0` | `~10.1 × 10.1` | `0.50` | `Package_QFP:LQFP-48_7x7mm_P0.5mm` | [x] *(48p sch OK; PCB pendente)* |
| **U8** | Isolador SWD bidirecional (`Ioff`) | TSSOP / VQFN / SC70 | *Confirmar MPN* | *Confirmar MPN* | *Confirmar MPN* | *Confirmar* | Datasheet fabricante | [ ] |
| **U9** | Load Switch Debugger (`DBG_3V3`) | SOT-23-5 / WSON-6 | *Confirmar MPN* | *Confirmar MPN* | *Confirmar MPN* | *Confirmar* | Datasheet fabricante | [ ] |
| **U10** | `TPS2121RUXR` (Power Mux, DNP Basic) | VQFN-HR-12 (`RUX`) | `2.0 × 2.5` | `2.0 × 2.5` | `~2.8 × 3.3` | `0.50` | **Land pattern exato TI `RUX`** (pads assimétricos!) | [ ] |
| **U11** | Isolador UART Logs (`Ioff`) | VSSOP-8 / SC70 / US8 | *Confirmar MPN* | *Confirmar MPN* | *Confirmar MPN* | *Confirmar* | Datasheet fabricante | [ ] |
| **EEPROM** | `93LC46B` / `93LC56B` (FT4232H) | SOIC-8 / SOT-23-6 | `~4.9 × 3.9` / `2.9 × 1.6` | *Confirmar* | *Confirmar* | `1.27` / `0.95` | Biblioteca oficial KiCad | [ ] |
| **Y1 / Y2** | Cristais `12 MHz` (U1) e `24 MHz` (U6) | SMD 4-pin (`3225` / `2016`) | `3.2 × 2.5` / `2.0 × 1.6` | — | `+0.5 mm` | — | `Crystal:Crystal_SMD_3225-4Pin_3.2x2.5mm` (ou 2016) | [ ] |
| **J1** | USB-C Macho (pescoço estendido) | Edge / Straddle / SMT | Shell `~8.25 mm` | *Confirmar MPN* | *Confirmar cutout* | `0.50` | Datasheet fabricante (**compatível PCB `1.6 mm`!**) | [ ] |
| **J2, J3** | SMA Fêmea `50 Ω` Edge-Launch | Edge-Launch | Corpo `~6.4–9.5 mm` | — | Folga porca/antena | — | Datasheet fabricante (**compatível PCB `1.6 mm`!**) | [ ] |
| **J4** | SWD Externo (Target `U2`) | Cortex Debug 10-pin keyed | `~7.6 × 5.1` | — | `~8.6 × 6.1` | `1.27` | `Connector_PinHeader_1.27mm:PinHeader_2x05_P1.27mm_Vertical_SMD` (com chave) | [ ] |
| **J5** | Controlo Debug (`3V3`, `DEBUG_EN`) | Header 2-pin | `5.08 × 2.54` | — | — | `2.54` | `PinHeader_1x02_P2.54mm_Vertical` (sem pino `GND` adjacente!) | [ ] |
| **J6** | USB-C Fêmea Auxiliar 5 V (DNP Basic) | USB-C 16p / 6p Power | `~8.9 × 7.3` | — | Folga borda PCB | `0.50` | Datasheet fabricante (furos mecânicos + shield) | [ ] |
| **J7** | SWD do Probe (`U7`) | 1×5 ST-Link (ou pads/1.27 mm) | `12.7 × 2.54` (THT) | — | Não furar planos RF/USB | `2.54` | `PinHeader_1x05_P2.54mm_Vertical` (ou SMD/DNP) | [ ] |

### 1.2 Verificação Anti-Mirror e Mecânica
- [ ] **Numeração anti-horária em Top View (`F.Cu`)** confirmada em todos os QFP/QFN (`U1`, `U2`, `U6`, `U7`, `U10`) — nunca copiada de *Bottom View* sem espelhar.
- [ ] **Módulos RF `U3`/`U4` (`E22`)**: pino 1, pads castellated e pino `ANT` conferidos contra a vista de topo (*Top View*) do datasheet Ebyte.
- [ ] **USB-C Macho (`J1`)**: pinagem de **plug macho** (espelhada face a fêmea) verificada; confirmado que `D+`/`D-` funcionam nas duas orientações (180°) e que `CC` é apenas o pino **A5**.
- [ ] **Exposed Pads (`EP`)** em `U6` (`USB2422`), `U10` (`TPS2121RUXR`) e `U5` (se QFN) têm máscara de solda/pasta segmentada (50–70% cobertura) e vias térmicas tentadas/ligadas a `GND`.
- [ ] **Espessura do PCB (`1.6 mm`)** confirmada compatível com `J1` (USB-C macho) e `J2`/`J3` (SMA edge-launch).
- [ ] **Margens mecânicas**: `U3` e `U4` com `≥ 1.5 mm` da borda da placa (evitar dano em V-score) e espaçamento entre `J2` e `J3` suficiente para apertar duas antenas SMA em simultâneo (`≥ 18–19 mm` centro-a-centro).
- [ ] **Marcadores de Pino 1** visíveis na serigrafia (`F.SilkS`) fora do corpo de todos os ICs e conectores (não tapados pelo componente após montagem).

---

## 2. Pull-Ups, Pull-Downs e Resistências Obrigatórias por Bus / IC

### 2.1 USB & Power Mux
- [x] **`J1` (USB-C Macho)**: `R1 = 5.1 kΩ` (±1% ou ±5%) em `CC (A5) → GND` (apenas 1 resistência num plug macho).
- [x] **`J6` (USB-C Auxiliar Fêmea)**: **2× `5.1 kΩ` independentes** (`R2` em `CC1_EXT → GND`, `R3` em `CC2_EXT → GND`; nunca partilhadas!).
- [ ] **`U6` (`USB2422`)**:
  - [ ] `RBIAS` (pino 24): **`12.0 kΩ ±1%` → `GND`** (obrigatório).
  - [ ] `RESET_N` (pino 15): pull-up **`10 kΩ` → `3V3`** + condensador RC (`1 µF` → `GND`) ou supervisor de reset.
  - [ ] `VBUS_DET` (pino 16): divisor resistivo a partir de `VBUS` (ex. `100 kΩ / 100 kΩ` → `~2.5 V`, dentro do limite de `3.3 V`).
  - [ ] `OCS_N1` e `OCS_N2`: **pull-up `10 kΩ` → `3V3`** (se não usados com switches de potência downstream, caso contrário o hub reporta falso overcurrent e desliga as portas!).
  - [ ] Straps de configuração (`CFG_SEL0`, `CFG_SEL1`, `NON_REM0`, `NON_REM1`): pull-ups/pull-downs conforme modo desejado (portas 1 e 2 *non-removable*, bus/self-powered).
- [ ] **`U1` (`FT4232HL`)**:
  - [ ] `REF` (pino 6): **`12.0 kΩ ±1%` → `GND`** (obrigatório).
  - [ ] `RESET#` (pino 14): pull-up **`10 kΩ` → `3V3`** (+ `100 nF` opcional para `GND`).
  - [ ] `TEST` (pino 13): ligado diretamente a **`GND`** (nunca flutuante!).
  - [ ] EEPROM (`93LC46B`/`56B`): pull-ups **`10 kΩ`** em `EECS`, `EECLK`, `EEDATA` + **`2.2 kΩ`** série em `EEDATA` (conforme FTDI AN_121 / datasheet).
- [ ] **`U10` (`TPS2121RUXR`)**:
  - [ ] Divisores resistivos de precisão em **`PR1`**, **`CP2`**, **`OV1`**, **`OV2`** (prioridade de fonte e limiar OVLO ~5.5–5.7 V).
  - [ ] Resistência **`ILM` → `GND`** dimensionada para o limite de corrente desejado (e controlo de inrush do `C1` 470 µF).
  - [ ] `ST` (open-drain): pull-up `10 kΩ–100 kΩ` → `3V3` se monitorizado pelo MCU (ou `NoConn` se não usado).

### 2.2 MCU Target (`U2` — `STM32G0B1RET6`) e Buses Periféricos
- [x] **`BOOT0` (`PB8-BOOT0`)**: `R12 = 10 kΩ` pull-down → `GND` (garante boot pela Flash em MCU virgem).
- [x] **`NRST`**: `R4 = 10 kΩ` pull-up → `3V3` + `C2 = 100 nF` → `GND`.
- [ ] **SPI1 (`U3` 433 MHz) & SPI2 (`U4` 868 MHz)**:
  - [x] `A_NSS` e `B_NSS`: **pull-up `10 kΩ` → `3V3`** (`R5`, `R6`) — impede seleção espúria durante reset do STM32.
  - [ ] `A_SCK`, `A_MOSI`, `A_MISO`, `B_SCK`, `B_MOSI`, `B_MISO`: **não precisam** de pull-up/pull-down externo (push-pull); opcionalmente resistências série `22–33 Ω` (ou os próprios links `0 Ω` trocáveis por `33 Ω`) para reduzir emissões EMI.
  - [x] `A_RESET`, `B_RESET`: pull-up `10 kΩ` → `3V3` (`R7`, `R8`, verificar se o módulo E22 já tem interno e deixar DNP se redundante).
  - [ ] `A_BUSY`, `B_BUSY`, `A_IRQ`, `B_IRQ`: saídas push-pull do SX126x — **não precisam** de pull-up externo (opcional pull-down fraco `100 kΩ` se necessário com rádio desligado via link de potência).
  - [ ] **`A_RXEN`, `A_TXEN`, `B_RXEN`, `B_TXEN` (RF Switch dos E22)**: **pull-down `10 kΩ–100 kΩ` → `GND`** nos 4 sinais para garantir RF switch em estado OFF seguro durante o reset/boot do STM32.
- [ ] **5× UARTs (`CTRL`, `DATA433`, `DATA868`, `MESH`, `LOG`)**:
  - [ ] Linhas TX/RX/RTS/CTS são push-pull — **não precisam** de pull-ups obrigatórios em operação normal.
  - [ ] **Exceção `LOG_TX`/`LOG_RX`**: se `U11` for um bus-switch passivo em Hi-Z quando `DEBUG_EN=0`, colocar pull-up fraco `100 kΩ` → `3V3` em `LOG_RX` (entrada RX do STM32) evita interrupções/framing errors falsos por pino flutuante com o debugger desligado!
- [x] **Bus SWD Target (`SWDIO`, `SWCLK`)**:
  - [x] `SWDIO`: pull-up **`10 kΩ` → `3V3`** (`R9`).
  - [x] `SWCLK`: pull-down **`10 kΩ` → `GND`** (`R10`).
- [ ] *(Se vier a existir I²C no futuro)*: **OBRIGATÓRIO** pull-ups `2.2 kΩ–4.7 kΩ` em `SCL` e `SDA` → `3V3` (atualmente não há bus I²C no design).

### 2.3 Debugger (`U7` — `STM32U073CCT6`) e Isolamento (`U8`, `U9`, `U11`, `J5`)
- [x] **`DEBUG_EN`**: `R11 = 10 kΩ` pull-down → `GND` (default = Debugger OFF).
- [ ] **`J5` (`3V3` → `DEBUG_EN`)**: opcionalmente resistência série `1 kΩ` no lado `3V3` para proteção contra curto acidental.
- [x] **`PROBE_BOOT0` (`PF3-BOOT0`, pino 44)**: `R13 = 10 kΩ` pull-down → `GND`. Se houver jumper/pad DFU, puxar **apenas para `DBG_3V3`** (nunca `3V3`!).
- [x] **`PROBE_NRST` (`PF2-NRST`, pino 7)**: `C3 = 100 nF` → `GND` (+ pull-up opcional `10 kΩ` → `DBG_3V3`).
- [x] **`USB_DP`/`USB_DM` do `U7` (`PA12`/`PA11`)**: **não precisa** de `1.5 kΩ` externo nem `27 Ω` série (integrados no `STM32U073`).
- [ ] **Sequenciamento `U8`/`U11`**: confirmar se os ICs escolhidos têm enable ativo-alto ou ativo-baixo (`OE#` precisa de inversor) e pull-up/pull-down adequado para permanecerem em Hi-Z até `DBG_3V3` estabilizar.

---

## 3. Condensadores de Desacoplamento (Decoupling) e Bulk Junto aos ICs

> **Regra de layout:** Todos os condensadores de `100 nF` (X7R / X5R, ≥ 10 V ou 16 V) devem ficar a **≤ 2–3 mm** do respetivo par `VDD/VSS`, com via direta ao plano `GND` interno (`In1.Cu`).

- [ ] **`U1` (`FT4232HL`)**:
  - [ ] `100 nF` em **cada** pino `VCCIO` (4× pinos) e `VREGIN` + `4.7 µF` em `VREGIN`.
  - [ ] `100 nF` em **cada** pino `VCORE` (3× pinos, `1.8 V` interno) + `3.3 µF` / `4.7 µF` bulk em `VCORE` (conforme datasheet FT4232H).
  - [ ] `VPLL` (`3.3 V`) e `VPHY` (`3.3 V`): **cada um** com ferrite bead (`600 Ω @ 100 MHz`) + `100 nF` + `4.7 µF` junto ao pino!
- [ ] **`U2` (`STM32G0B1RET6`)**:
  - [ ] `100 nF` em cada par `VDD/VSS` + `4.7 µF` bulk local.
  - [ ] `VDDA/VREF+`: `100 nF` + `1 µF` (+ ferrite bead opcional se usar ADC).
  - [ ] `VBAT`: ligado a `3V3` com `100 nF` (se partilhado ou separado).
- [ ] **`U3` (`E22-400M22S`) & `U4` (`E22-900M22S`) — CRÍTICO PARA TX 22 dBm**:
  - [ ] Em **cada** módulo RF: `100 nF` (alta frequência) + `10 pF`/`47 pF` (opcional filtro RF 868/433) + **`10 µF`–`22 µF` X5R/X7R** (ou `47 µF` low-ESR) muito próximo do pino `VCC` para absorver os picos de `~130–140 mA` em TX sem afundar `3V3`!
- [ ] **`U5` (Buck `3.3 V`)**:
  - [ ] Condensadores de entrada (`CIN`, ex. `10 µF` + `100 nF`, rating ≥ 10 V/16 V) e saída (`COUT`, ex. `22 µF` + `100 nF` low-ESR) exatamente conforme datasheet do regulador escolhido (atenção ao *DC bias derating* em 0603!).
  - [ ] Condensador de bootstrap (`CBST`) / soft-start (`CSS`) se requerido pelo regulador.
- [ ] **`U6` (`USB2422`)**:
  - [ ] `100 nF` em **cada** pino `VDD33` + `4.7 µF` bulk local.
  - [ ] `VDDPLL` / `VDDCR18` (regulador interno `1.8 V` do USB2422): **`1.0 µF` (ou `4.7 µF` conforme datasheet USB2422) + `100 nF`** obrigatório para estabilidade do PLL 480 MHz!
- [x] **`U7` (`STM32U073CCT6`)** *(no esquemático; colocação física ≤ 2–3 mm no PCB pendente)*:
  - [x] `C4` (`100 nF` pino 24 `VDD`), `C5` (`100 nF` pino 48 `VDD`), `C6` (`100 nF` pino 36 `VDDUSB`), `C7` (`100 nF`) + `C8` (`1 µF`) no pino 9 `VDDA`, `C9` (`100 nF` pino 1 `VBAT`), `C10` (`4.7 µF` bulk `DBG_3V3`).
- [ ] **`U8`, `U9`, `U11` (Isoladores & Load Switch)**:
  - [ ] `100 nF` em `VCC` de `U8` e `U11` junto a cada IC.
  - [ ] `U9` (load switch): `1 µF` na entrada (`3V3`) + `1 µF`–`10 µF` na saída (`DBG_3V3`, garantir `COUT ≤ CIN` ou soft-start para não causar dip em `3V3` ao ligar o debugger!).
- [ ] **`U10` (`TPS2121RUXR`) & `VBUS` / `SYS_5V`**:
  - [ ] **Limite USB de inrush**: capacitância diretamente visível em `VBUS` (`J1`) **≤ 10 µF** (tipicamente `1 µF–4.7 µF` antes do limitador de corrente / `U10`).
  - [ ] `C1` (`470 µF` bulk, DNP na Basic): colocado **exclusivamente após** limitação de corrente / soft-start (`SYS_5V` via `U10` com `ILM` e soft-start, nunca direto a `VBUS` com `SJ1` fechado sem inrush control!).

---

## 4. Verificação de Pinos e Suporte de Buses (AF / Pin Mux / DMA)

### 4.1 `U2` (`STM32G0B1RET6` — LQFP-64) — Validar no STM32CubeMX
- [ ] **4× USARTs com Hardware Flow Control (`TX`, `RX`, `RTS`, `CTS`)** simultâneos sem conflito de pinos:
  - [ ] Canal A (`CTRL`): USARTx `TX/RX/RTS/CTS` mapeado e verificado no LQFP-64.
  - [ ] Canal B (`DATA433`): USARTy `TX/RX/RTS/CTS` mapeado e verificado no LQFP-64.
  - [ ] Canal C (`DATA868`): USARTz `TX/RX/RTS/CTS` mapeado e verificado no LQFP-64.
  - [ ] Canal D (`MESH`): USARTw `TX/RX/RTS/CTS` mapeado e verificado no LQFP-64.
  - *(Nota: como `U2` não usa USB interno, `PA11/PA12` estão livres para `USART1_CTS/RTS`!)*
- [ ] **5.ª UART (`LOG_TX`/`LOG_RX`)** mapeada num USART/LPUART independente sem conflito.
- [ ] **2× SPIs independentes (`SPI1` para 433 MHz, `SPI2` para 868 MHz)**: `SCK`, `MISO`, `MOSI` em pinos AF nativos + `NSS` em GPIO (controlo por software recomendado para SX126x).
- [ ] **Controlos de Rádio**: `A_BUSY`, `A_IRQ`, `A_RESET`, `A_RXEN`, `A_TXEN` e `B_BUSY`, `B_IRQ`, `B_RESET`, `B_RXEN`, `B_TXEN` sem conflitos.
- [ ] **Conflitos de `EXTI` (Interrupções Externas)**: `A_IRQ` (`DIO1` 433) e `B_IRQ` (`DIO1` 868) **NÃO podem partilhar o mesmo número de linha EXTI** (ex.: nunca pôr `PA5` e `PB5` ambos como IRQ!).
- [ ] **Canais DMA (`DMAMUX`)**: confirmar no CubeMX que os canais DMA disponíveis no `STM32G0B1` (12 canais DMA1+DMA2) cobrem os 4× USARTs (TX/RX) + 2× SPIs conforme estratégia de firmware RTX5.
- [ ] **SWD preservado**: `PA13 (SWDIO)` e `PA14 (SWCLK)` não partilhados com nenhum periférico; `PB8-BOOT0` não puxado para HIGH por nenhum periférico no arranque!

### 4.2 `U1` (`FT4232HL`) — 4 Canais UART + RTS/CTS
- [ ] Confirmar que **todos os 4 canais (`ADBUS`, `BDBUS`, `CDBUS`, `DDBUS`)** suportam `TXD`, `RXD`, `RTS#`, `CTS#` nos pinos `xDBUS0..3`.
- [ ] **Cruzamento obrigatório `U1 ↔ U2` (em todos os 4 canais)**:
  - `FT4232H TXD` → `STM32 USART_RX`
  - `FT4232H RXD` → `STM32 USART_TX`
  - `FT4232H RTS#` → `STM32 USART_CTS`
  - `FT4232H CTS#` → `STM32 USART_RTS`
- [ ] Confirmar `USB_DP`/`USB_DM` (`HUB1_DP`/`HUB1_DM`) não trocados em `U1` e `U6`.

### 4.3 `U7` (`STM32U073CCT6` — LQFP-48, DS14548)
- [x] **48/48 pinos** conferidos contra `MCU_ST_STM32U0:STM32U073CCTx` (`DS14548`).
- [x] `PA11` (pino 32) = `USB_DM` (`HUB2_DM`), `PA12` (pino 33) = `USB_DP` (`HUB2_DP`), `VDDUSB` (pino 36) = `DBG_3V3`.
- [x] `PA2`/`PA3` (pinos 12/13) = `USART2_TX`/`USART2_RX` (`DBG_LOG_TX`/`DBG_LOG_RX`) — confirmar cruzamento no lado `U2` (`LOG_TX → U2_RX`, `LOG_RX → U2_TX`).
- [x] `PA4`/`PA5`/`PA6` = GPIO Port A para SWD target; `PA13`/`PA14` (pinos 34/37) = SWD próprio do `U7` (`J7`).
- [ ] Validar em firmware que `VDDUSB` é habilitado via bit `USV` no registo `PWR` antes de iniciar USB, e que `HSI48 + CRS` bloqueia corretamente ao SOF do `USB2422`.

### 4.4 Isolamento SWD (`U8`) e UART (`U11`) + Sinais de Sistema
- [ ] **`U8`**: suporta **`SWDIO` bidirecional** e **`NRST` open-drain bidirecional** (ex.: FET bus switch com `Ioff`, não buffer unidirecional!).
- [ ] **`U8` e `U11`**: têm especificação **`Ioff` (partial power-down)** garantindo fuga `≤ poucos µA` quando `DBG_3V3 = 0 V` e `3V3 = 3.3 V` (zero backfeed de `U2 → U7` e vice-versa).
- [ ] **Relógio do `U2` (`STM32G0B1RET6`)**: decidir explicitamente entre `HSI16` interno (validar margem `±2%` em temperatura com 4 UARTs `≥ 921.6 kbps`) vs **cristal HSE (`8/16 MHz`)**.
- [ ] **Deteção de fonte ativa e enumeração USB no `U2`**:
  - [ ] Ligar pino **`ST` do `TPS2121`** (e/ou divisor resistivo `VBUS`/`VBUS_EXT`) a GPIO/ADC de `U2` para o firmware distinguir **AUX 5 V (`J6`)** vs **OTG (`J1`)** e arbitrar TX +22 dBm simultâneo.
  - [ ] Ligar **`PWREN#` (`FT4232HL`)** ou **`SUSP_IND` (`USB2422`)** a GPIO de `U2` para **só autorizar TX RF após enumeração USB** (respeitar `≤ 100 mA` pré-enumeração).
- [ ] **Tensões lógicas e pinos não 5V-tolerant**: confirmar que todos os domínios operam a `3.3 V` e que **nenhum sinal `5 V` (`VBUS`/`VBUS_EXT`)** liga diretamente a pinos não-FT de `U2` ou `U7` (especialmente pinos `TTa`, `NRST`, `BOOT0`).
- [ ] **Proteção de `J4` (SWD Externo)**: confirmar que `VTREF` em `J4` é apenas *sense* (nunca alimentar `3V3` pelo ST-Link em paralelo com `U5`) e garantir `J5` aberto ao ligar programador externo.

---

## 5. Regras de EMC, Integridade de Sinal, USB-HS e RF (PCB 4 Camadas)

### 5.1 Stackup e Planos de Referência
- [ ] **Stackup 4 camadas** definido com o fabricante (ex. PCBWay `JLC04161H-7628` ou equivalente PCBWay 4L `1.6 mm`):
  - `L1 (F.Cu)`: Sinais, RF `50 Ω`, USB `90 Ω`, componentes
  - `L2 (In1.Cu)`: **Plano `GND` contínuo e sólido** (referência primária para USB e RF — **ZERO cortes/splits** sob pistas USB, RF, SPI ou cristais!)
  - `L3 (In2.Cu)`: Alimentação (`3V3`, `SYS_5V`, `DBG_3V3`) + ilhas `GND` (com `GND` contínuo debaixo da zona RF `U3`/`U4`/`J2`/`J3`!)
  - `L4 (B.Cu)`: Sinais secundários + preenchimento `GND` com *via stitching*.
- [ ] **Sem splits no plano GND** entre zona digital, USB e RF — usar particionamento físico (USB à esquerda, digital ao centro, RF à direita) sobre um único plano `GND` contínuo.

### 5.2 USB 2.0 High-Speed (`480 Mbps`: `J1 ↔ U6 ↔ U1`) e Full-Speed (`U6 ↔ U7`)
- [ ] **Impedância diferencial `90 Ω ±10%`** calculada para o dielétrico real entre `L1` e `L2` (largura + espaçamento exatos do fabricante).
- [ ] **Comprimento emparelhado (*length matching*)**: `|L(D+) - L(D-)| ≤ 0.15 mm` (máx. `0.5 mm`) nos pares HS (`USB_DP/DM`, `HUB1_DP/DM`).
- [ ] **ZERO stubs**: sem test points em T, sem resistências `0 Ω` em derivação; ESD (`USBLC6-2SC6` / `TPD2E001` / `TPD4E05U06`, capacitância `< 1 pF`) colocado **em linha (flow-through)** o mais próximo possível de `J1`.
- [ ] **Sem mudanças de camada** nos pares USB HS; se inevitável, colocar **2 vias de retorno `GND`** imediatamente adjacentes a cada transição de via.
- [ ] Afastar pares USB `≥ 3×` a largura da pista de sinais ruidosos (buck `U5`, SPI, cristais, RF).

### 5.3 RF (`433 MHz` e `868 MHz` — `U3 ↔ J2`, `U4 ↔ J3`) e Coexistência
- [ ] **Linha de transmissão `50 Ω`** (CPWG — *Coplanar Waveguide with Ground* referenciado a `L2 GND`) o mais curta e direta possível entre o pad `ANT` do módulo e o pino central do SMA (sem ângulos de 90°, sem stubs, sem vias no sinal!).
- [ ] **Via stitching (`GND` fence)** ao longo de ambos os lados das pistas RF `50 Ω` e ao redor das zonas dos módulos `U3`/`U4` com passo `≤ 2–3 mm` (bem abaixo de `λ/20` a 868 MHz).
- [ ] **Rede de adaptação π (*Pi-network*)** (3 footprints 0402: série `0 Ω`, 2× shunt DNP) entre `ANT` e SMA para permitir sintonia VNA na revisão DEV, se espaço permitir.
- [ ] **⚠️ Coexistência 433 MHz ↔ 868 MHz (Harmónica 2.ª!)**:
  - A **2.ª harmónica de `433.92 MHz` cai em `867.84 MHz`** — diretamente dentro da banda LoRa de `868 MHz`!
  - Maximizar separação física entre `U3`/`J2` e `U4`/`J3`, colocar vedação de vias `GND` entre os dois módulos, e prever na versão DEV espaço para filtro passa-baixo/SAW ou blindagem adicional se o teste de coexistência mostrar dessensibilização do recetor 868 MHz durante TX a 433 MHz!
- [ ] **Proteção ESD RF** (se incluída): díodo de ultra-baixa capacitância (`≤ 0.25 pF`, ex. `PESD5V0R1BSF` / `ESD5Z...` rated para >22 dBm TX sem ceifar o sinal!).
- [ ] **Filtragem da alimentação RF (`U3`, `U4`)**: prever **ferrite bead** de baixa resistência DC (`< 0.1 Ω`, `≥ 500 mA`, ex. `600 Ω @ 100 MHz`) em série antes dos condensadores `10–22 µF + 100 nF` de cada módulo E22 (pode partilhar o footprint `0805` do link `R_PWR_U3`/`R_PWR_U4`!) para bloquear ruído de comutação do buck `U5`.
- [ ] **Conformidade RF / Medição Espectral (ETSI EN 300 220)**: prever medição em analisador de espectro (potência ERP, 2.ª harmónica de `433 MHz` em `868 MHz` e 3.ª harmónica) e validar limites regulamentares (`+10 dBm` em 433 MHz; `+14/+27 dBm` em 868 MHz conforme sub-banda).

### 5.4 Cristais, Buck (`U5`) e ESD Geral
- [ ] **Cristais `Y1 (12 MHz)` e `Y2 (24 MHz)`**: pistas ultra-curtas, simétricas, sem vias, rodeadas por anel `GND`, **sem nenhuma outra pista** a passar por baixo em `L1/L2`.
- [ ] **Buck `U5` (Fonte Comutada)**:
  - [ ] Loop quente (`CIN → SW → indutor → COUT → GND`) o mais pequeno possível, com cobre largo e curto; **nó `SW` mínimo** (é a maior fonte de ruído irradiado!).
  - [ ] Indutor **blindado** (*shielded*) afastado dos módulos RF `U3`/`U4` e dos cristais.
  - [ ] Pista de `FB` (feedback) afastada do nó `SW` e do indutor.
- [ ] **Proteção ESD** junto a todas as interfaces expostas ao utilizador: `J1` (VBUS + D+/D- + CC), `J6` (VBUS_EXT + CC1/CC2), `J4` (SWD se exposto).
- [ ] **Shield metálico de `J1` e `J6` (USB-C)**: ligado firmemente a `GND` (com múltiplos pinos/vias THT de ancoragem mecânica para suportar esforço de inserção no telemóvel sem arrancar pads; nunca deixar a carcaça a flutuar).
- [ ] **Hot-plug ringing em `VBUS`**: adicionar TVS unidirecional `5 V` em `VBUS`/`VBUS_EXT` (ou escolher buck `U5` com `V_IN_MAX ≥ 12–18 V`) para proteger contra picos de `7–9 V` ao ligar cabos USB longos com condensadores cerâmicos de baixo ESR.
- [ ] **Dielétricos e *DC bias* dos condensadores**:
  - [ ] `C0G / NP0` obrigatório nos condensadores de carga dos cristais (`Y1`, `Y2`) e rede π RF.
  - [ ] `X7R / X5R` (nunca `Y5V`!) com tensão nominal **≥ 2× a tensão do rail** (`≥ 10 V` / `16 V` em rails `3.3 V` e `5 V`) para evitar perda severa de capacitância por *DC bias* em 0603.

---

## 6. Cálculos de Potência e Orçamento Energético por Fonte

### 6.1 Tabela de Consumo Estimado (Rail `3V3` e `5V`)

| Subsistema | Ref | Tensão | Corrente Típica (Idle/RX) | Corrente Pico (TX / Carga Máx.) | Notas |
|---|---|---|---|---|---|
| Hub USB 2.0 HS | `U6` (`USB2422`) | `3.3 V` | `~45 mA` | `~65 mA` | 2 portas ativas (HS + FS) |
| Quad USB-UART | `U1` (`FT4232HL`) | `3.3 V` | `~55 mA` | `~75 mA` | USB HS 480 Mbps ativo |
| MCU Principal | `U2` (`STM32G0B1RET6`) | `3.3 V` | `~12 mA` | `~20 mA` | 64 MHz + 5 UART + 2 SPI |
| Debugger (Opcional) | `U7` (`STM32U073CCT6`) | `3.3 V` (`DBG_3V3`) | `0 mA` (OFF) / `~8 mA` (ON) | `~15 mA` | Desligado por defeito (`J5` aberto) |
| Rádio 433 MHz (+22 dBm) | `U3` (`E22-400M22S`) | `3.3 V` | `~10 mA` (RX) / `<2 µA` (Sleep) | **`~135 mA`** (TX +22 dBm) | Confirmar datasheet exato E22-400M22S |
| Rádio 868 MHz (+22 dBm) | `U4` (`E22-900M22S`) | `3.3 V` | `~10 mA` (RX) / `<2 µA` (Sleep) | **`~125 mA`** (TX +22 dBm) | Confirmar datasheet exato E22-900M22S |
| Isoladores / Misc | `U8, U9, U11`, pull-ups | `3.3 V` | `<3 mA` | `<5 mA` | — |
| **TOTAL no rail `3V3`** | — | **`3.3 V`** | **`~135 mA`** (RX dual, dbg OFF) | **`~275 mA`** (1× TX) / **`~440 mA`** (2× TX simultâneo + dbg ON) | — |

### 6.2 Conversão `5 V → 3.3 V` (Buck `U5`, eficiência assumida `η = 85%`, `VBUS_min = 4.5 V`)
- Fórmula: $I_{5V} = \frac{V_{3V3} \times I_{3V3}}{\eta \times V_{5V}}$
- **Cenário 1 — RX Dual (dbg OFF)**: $I_{3V3} \approx 135\text{ mA} \implies I_{5V} \approx \mathbf{116\text{ mA}}$ (@ 4.5 V) ✅
- **Cenário 2 — 1 Rádio em TX +22 dBm + outro em RX (dbg OFF)**: $I_{3V3} \approx 275\text{ mA} \implies I_{5V} \approx \mathbf{237\text{ mA}}$ (@ 4.5 V) ✅
- **Cenário 3 — 2 Rádios em TX +22 dBm SIMULTÂNEO + Debugger ON (pior caso)**:
  - $I_{3V3} \approx 440\text{ mA}$ ($P_{3V3} \approx 1.45\text{ W}$)
  - $I_{5V} \approx \frac{3.3 \times 0.44}{0.85 \times 4.5} \approx \mathbf{380\text{ mA}}$ (@ 4.5 V) — com margem de transientes/TCXO/picos: **`~420–450 mA`**!

### 6.3 Checklist de Verificação da Fonte e Margens
- [ ] **Buck `U5` dimensionado com margem ≥ 2×**: corrente nominal mínima **`≥ 1.0 A`** (recomendado `1.5 A–2.0 A` buck síncrono com baixo ripple `< 20 mVpp` para alimentar RF!). **NÃO usar LDO linear** (`(5.0 - 3.3) × 0.44 A = 0.75 W` aqueceria demasiado o dongle!).
- [ ] **Limite da fonte USB Host / Telemóvel OTG**:
  - [ ] USB 2.0 standard = `500 mA` máx. (e `100 mA` antes de enumeração! Configurar `bMaxPower = 500 mA` nos descritores do `USB2422` e `FT4232HL` e **não transmitir RF antes da enumeração USB**!).
  - [ ] **Telemóvel OTG**: muitos smartphones limitam OTG a `300–500 mA` — validar que com **2× TX simultâneo +22 dBm** não há *brownout* no telemóvel (ou usar alimentação auxiliar `J6` na variante `Full`, ou arbitrar no firmware para limitar potência/TX simultâneo quando em modo *bus-powered*).
- [ ] **Inrush Current (`USB 2.0 Spec`)**: capacitância total vista em `VBUS` (`J1`) **≤ 10 µF**; variante `Basic` (`SJ1` fechado) **tem de manter `C1` = DNP** ou incluir limitador de inrush!
- [ ] **Power Mux `U10` (`TPS2121RUXR`)**: corrente nominal (`4.5 A` máx.), `R_ON (~56 mΩ)` → queda de tensão `@ 0.5 A = 28 mV`, dissipação `14 mW` (térmicamente trivial); `ILM` ajustado (ex. `1.0 A–1.5 A`) e proteção contra corrente reversa verificada entre `J1` (`VBUS`) e `J6` (`VBUS_EXT`).
- [ ] **Load Switch `U9` (`DBG_3V3`)**: suporta `≥ 100 mA` com *slew-rate / soft-start* controlado para carregar `C4..C10` (`~6.2 µF`) sem provocar queda de tensão em `3V3` nem reset ao `STM32`/`FT4232H`.
- [ ] **Largura de pistas e vias de potência**: pistas `VBUS`, `SYS_5V` e `3V3` dimensionadas para `≥ 1.0 A` (`≥ 0.5–0.8 mm` em cobre 1 oz para `ΔT < 10 °C`) com múltiplas vias de costura junto a `U5`, `U10`, `U3` e `U4`.
- [ ] **Modo USB Suspend (`≤ 2.5 mA`)**: verificar comportamento se o host suspender o barramento USB (ou documentar requisito de *suspend*).

---

## 7. Desativar Qualquer Componente via Resistência `0 Ω` (Isolamento de Alimentação)

> **Regra DEV:** Cada subsistema deve ter uma resistência **`0 Ω` (0603 ou 0805 para correntes > 200 mA)** em série na sua linha de alimentação, com **2 Test Points (TP antes e depois)**, permitindo:
> 1. **Desativar fisicamente** o componente removendo a `0 Ω`;
> 2. **Medir o consumo exato** desse bloco com amperímetro / Power Profiler (PPK2) entre os dois TPs;
> 3. **Injetar tensão de bancada** isoladamente no bloco durante o *bring-up*.

| Link `0 Ω` (Sugestão) | Rail Isolado | Bloco Desativado | Encapsulamento | TPs Ambos os Lados | Aviso Anti-Backfeed | Verificado |
|---|---|---|---|---|---|---|
| `R_PWR_U6` | `3V3 → 3V3_HUB` | `U6` (`USB2422`) | 0603 (`0 Ω`, ≥1 A) | [ ] TP_IN / TP_OUT | Desligar `VBUS_DET` / remover `J1` | [ ] |
| `R_PWR_U1` | `3V3 → 3V3_FTDI` | `U1` (`FT4232HL`) | 0603 (`0 Ω`, ≥1 A) | [ ] TP_IN / TP_OUT | Isolar UARTs (`0 Ω` Secção 8) se `U2` estiver ON | [ ] |
| `R_PWR_U2` | `3V3 → 3V3_MCU` | `U2` (`STM32G0B1RET6`) | 0603 (`0 Ω`, ≥1 A) | [ ] TP_IN / TP_OUT | Isolar UARTs/SPI/SWD se outros blocos estiverem ON | [ ] |
| `R_PWR_U3` | `3V3 → 3V3_RF433` | `U3` (`E22-400M22S`) | **0805** (`0 Ω`, baixa R) | [ ] TP_IN / TP_OUT | Colocar GPIOs SPI/CTRL de `U2` em Hi-Z ou remover `0 Ω` SPI-A | [ ] |
| `R_PWR_U4` | `3V3 → 3V3_RF868` | `U4` (`E22-900M22S`) | **0805** (`0 Ω`, baixa R) | [ ] TP_IN / TP_OUT | Colocar GPIOs SPI/CTRL de `U2` em Hi-Z ou remover `0 Ω` SPI-B | [ ] |
| `R_PWR_U7` | `DBG_3V3 → 3V3_PROBE` | `U7` (`STM32U073CCT6`) | 0603 (`0 Ω`) | [ ] TP_IN / TP_OUT | Já isolado por `U9` + `U8` + `U11` quando `J5` aberto | [ ] |
| `R_PWR_3V3` | `U5_OUT → 3V3` | Buck `U5` separado da carga | **0805** (`0 Ω`, ≥2 A) | [ ] TP_IN / TP_OUT | Permite testar `U5` em vazio antes de ligar os ICs! | [ ] |
| `SJ1` / `U10` | `VBUS → SYS_5V` | Power Mux vs Bypass | Solder jumper / DNP | [ ] TP_VBUS / TP_SYS5V | **Nunca** fechar `SJ1` com `U10` montado! | [ ] |

- [ ] **Atenção obrigatória no bring-up:** Quando um IC é desativado removendo a sua `0 Ω` de alimentação, **garantir que nenhum outro IC alimentado envia nível lógico HIGH para os seus pinos de sinal** (caso contrário há backfeed pelos díodos ESD!) — usar em conjunto os links `0 Ω` da Secção 8.

---

## 8. Desligar Ligações ao MCU (`U2`) com Resistências `0 Ω` (Isolamento de Sinais)

> **Regra DEV:** Todos os sinais digitais de baixa/média velocidade que entram ou saem do `STM32G0B1RET6` (`U2`) têm uma resistência **`0 Ω` (0603)** em série + **Test Point (TP) de ambos os lados** (lado periférico e lado MCU), permitindo desligar completamente o MCU de qualquer bus para testar `FT4232H`, rádios LoRa ou debugger de forma independente (ou injetar sinais externos).

### 8.1 Sinais que DEVEM ter `0 Ω` (0603) + TP em ambos os lados
- [ ] **FT4232H Canal A (`CTRL`) ↔ `U2`** (4 linhas): `CTRL_TX`, `CTRL_RX`, `CTRL_RTS`, `CTRL_CTS` — 4× `0 Ω` + 8 TPs.
- [ ] **FT4232H Canal B (`DATA433`) ↔ `U2`** (4 linhas): `DATA433_TX`, `DATA433_RX`, `DATA433_RTS`, `DATA433_CTS` — 4× `0 Ω` + 8 TPs.
- [ ] **FT4232H Canal C (`DATA868`) ↔ `U2`** (4 linhas): `DATA868_TX`, `DATA868_RX`, `DATA868_RTS`, `DATA868_CTS` — 4× `0 Ω` + 8 TPs.
- [ ] **FT4232H Canal D (`MESH`) ↔ `U2`** (4 linhas): `MESH_TX`, `MESH_RX`, `MESH_RTS`, `MESH_CTS` — 4× `0 Ω` + 8 TPs.
- [ ] **UART Logs (`U11`) ↔ `U2`** (2 linhas): `LOG_TX`, `LOG_RX` — 2× `0 Ω` + 4 TPs.
- [ ] **Rádio 433 MHz (`U3`) ↔ `U2`** (9 linhas): `A_SCK`, `A_MISO`, `A_MOSI`, `A_NSS`, `A_BUSY`, `A_IRQ`, `A_RESET`, `A_RXEN`, `A_TXEN` — 9× `0 Ω` + 18 TPs. *(Nota: os `0 Ω` em `SCK/MOSI/MISO` podem ser trocados por `22–33 Ω` se houver overshoot/EMI!)*
- [ ] **Rádio 868 MHz (`U4`) ↔ `U2`** (9 linhas): `B_SCK`, `B_MISO`, `B_MOSI`, `B_NSS`, `B_BUSY`, `B_IRQ`, `B_RESET`, `B_RXEN`, `B_TXEN` — 9× `0 Ω` + 18 TPs.
- [ ] **SWD / Reset do Target (`U8`/`J4` ↔ `U2`)** (3 linhas): `SWDIO`, `SWCLK`, `NRST` — acesso de TP garantido (evitar stubs longos em `SWCLK`; `0 Ω` inline se necessário isolar `U2` do barramento SWD).
- [ ] **Pontos de Massa (`GND` Test Points)**: distribuídos perto de cada grupo de TPs (USB, FTDI, MCU, RF 433, RF 868, Power) para pontas de prova de osciloscópio com mola curta!

### 8.2 Exceções Obrigatórias — ONDE **NÃO** COLOCAR `0 Ω` / TEST POINTS COM STUB
- [ ] **❌ NUNCA colocar `0 Ω` 0603 nem Test Points com stub nas linhas USB High-Speed (`USB_DP/DM`, `HUB1_DP/DM`)** — destrói a impedância diferencial de `90 Ω` e causa reflexões a 480 Mbps!
- [ ] **❌ NUNCA colocar Test Points com stub nas pistas RF `50 Ω` (`RF_A`, `RF_B`)** — usar apenas rede π inline `0402` se necessário.

---

## 9. Usabilidade em Bancada DEV, DFM/Montagem e Bring-Up Seguro

### 9.1 Diagnóstico e Recuperação em Bancada
- [ ] **LEDs de estado (desativáveis via `0 Ω` para medições de baixo consumo)**:
  - [ ] `3V3` Power ON (LED + `1 kΩ–2.2 kΩ` + `0 Ω` opcional).
  - [ ] `DBG_3V3` Debugger ON (confirma visualmente se `J5`/`U9` ativou o debugger).
  - [ ] 1× LED de estado/heartbeat em `U2` (`STM32G0B1`) e 1× em `U7` (`STM32U073`).
- [ ] **Acesso a Reset e Bootloader/DFU**:
  - [ ] Pads/botão de Reset manual (`NRST → GND` em `U2` e `PROBE_NRST → GND` em `U7`).
  - [ ] Pads/jumper de recuperação DFU em `U7` (`PROBE_BOOT0 → DBG_3V3`, **nunca `3V3`**) e `BOOT0 → 3V3` em `U2` (opcional).
- [ ] **Enumeração USB inicial (`FT4232HL` + `USB2422`)**:
  - [ ] Confirmar que `FT4232HL` arranca com EEPROM virgem (VID/PID padrão FTDI) para gravação via `FT_Prog` através da própria porta USB.
  - [ ] Confirmar configuração *bus-powered* vs *self-powered* e `bMaxPower` no `USB2422` (evitar que Windows/Android recuse enumerar dispositivos downstream por orçamento de corrente mal reportado).
- [ ] **TCXO e Proteção do PA dos Módulos RF (`U3`, `U4`)**:
  - [ ] Confirmar tensão/alimentação do TCXO interno dos módulos `E22-400M22S` / `E22-900M22S` (`DIO3` 1.8 V vs `VCC` 3.3 V).
  - [ ] **Regra de bancada:** NUNCA ativar TX (+22 dBm) em `U3`/`U4` sem antena ou carga de `50 Ω` ligada em `J2`/`J3` (risco de dano ao PA por VSWR elevado).

### 9.2 DFM / Montagem SMT / Mecânica & Sourcing (PCBWay / JLCPCB)
- [ ] **Montagem preferencialmente numa só face (`F.Cu`)** (ou apenas passivos leves em `B.Cu`, evitando reflow duplo com módulos E22 pesados).
- [ ] **3× Fiduciais globais assimétricos** em cada face com componentes SMT (`Ø 1.0 mm` cobre + `Ø 2.0 mm` abertura de soldermask, livre de serigrafia).
- [ ] **Larguras mínimas / folgas / furos** dentro das regras standard do fabricante (ex.: pista/espaço `≥ 0.127 mm` / 5 mil, via `≥ 0.3 mm` furo / `0.6 mm` pad) + pedido de **controlo de impedância (`90 Ω` USB / `50 Ω` RF)** com o stackup real.
- [ ] **Gestão térmica**: vias térmicas e áreas de cobre em `U5` (buck), `U10` (`TPS2121`), `U3` e `U4` (TX contínuo +22 dBm dissipa `~0.4–0.5 W` por módulo).
- [ ] **Mecânica de dongle em telemóvel**: validar pescoço USB-C (`≥ 6–8 mm` livre, sem componentes altos na zona da capa, ancoragem THT reforçada contra momento fletor de `90 mm` + 2 antenas SMA) e prever furos de fixação para caixa 3D.
- [ ] **Serigrafia de bancada (`F.SilkS`)**: revisão (`R2-DEV`), espaço para nº de série, etiquetas `433 MHz` (`J2`), `868 MHz` (`J3`), `AUX 5V ONLY` (`J6`), `DEBUG EN (CLOSED=ON)` (`J5`), pinout/pino 1 de `J4`/`J7` e aviso `NO TX WITHOUT 50R LOAD`.
- [ ] **Stock real e ciclo de vida (Sourcing)**: confirmar disponibilidade efetiva (DigiKey/Mouser/LCSC/PCBWay) e ausência de *NRND/EOL* para todos os MPNs antes de fechar o layout — em especial **`J1` (USB-C macho de pescoço estendido)**.

### 9.3 Sequência de Bring-Up Seguro (1.ª Ligação da Placa DEV)
- [ ] **Passo 1 (Sem energia):** Medir resistência `VBUS–GND`, `SYS_5V–GND`, `3V3–GND` e `DBG_3V3–GND` com multímetro (confirmar ausência de curto).
- [ ] **Passo 2 (Fonte de bancada limitada a `100 mA`):** Remover `R_PWR_3V3` e validar saída do buck `U5` em vazio (`3.30 V ±2%`, ripple baixo).
- [ ] **Passo 3 (Ligar subsistemas 1 a 1 via `0 Ω`):** Montar `R_PWR_3V3` → `U6` (confirmar enumeração do Hub USB) → `U1` (confirmar 4 portas COM no PC) → `U2` (confirmar ligação SWD em `J4`) → `U7` (ligar `J5`, confirmar `DBG_3V3` e enumeração CMSIS-DAP + CDC) → `U3` e `U4` (com cargas `50 Ω` nas SMAs!).
- [ ] **Passo 4 (Teste obrigatório de Backfeed):** Com `J5` aberto (debugger OFF) e `U2` alimentado a enviar dados em `LOG_TX`, medir `DBG_3V3` e pinos do `U7` — **tem de ser `< 0.1 V`**!

---

## 10. Gate Final de Aprovação (Antes de Encomendar a Placa DEV)

- [ ] Esquemático migrado para **KiCad nativo (`.kicad_sch`)** — zero símbolos lógicos da cache v4.
- [ ] `ci/check_libraries.py`: **0 entradas `UNRESOLVED` ou `MISSING`**.
- [ ] `kicad-cli sch erc --exit-code-violations`: **0 erros e 0 warnings não justificados**.
- [ ] `kicad-cli pcb drc --exit-code-violations`: **0 erros DRC** (clearances, anéis anulares, silkscreen, courtyards, *unconnected items = 0*).
- [ ] **Paridade 100%** entre `.kicad_sch` ↔ `.kicad_pcb` ↔ `components.csv` ↔ `BOM` (variantes `Basic` e `Full`) ↔ `CPL` (Pick-and-Place).
- [ ] **PDFs do esquemático e PCB (Top/Bottom/Fab)** inspecionados visualmente (sem textos sobrepostos à legenda, pino 1 visível em todos os componentes, polaridade de condensadores/díodos clara).
- [ ] **Revisão manual do ficheiro CPL (rotações 0°/90°/180°/270°)** no visualizador da PCBWay/JLCPCB antes de pagar a montagem SMT!
