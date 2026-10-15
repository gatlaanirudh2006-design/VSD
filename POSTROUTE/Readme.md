# 🚀 VSDBabySoC SKY130 HD — Post-Route Static Timing Analysis

## 📘 Overview

This project documents the physical-design flow and post-route **Static Timing Analysis (STA)** of VSDBabySoC using the **SKY130 HD standard-cell library**.

The report analyzes setup and hold timing across **16 Process-Voltage-Temperature (PVT) corners**, supported by physical-design screenshots, timing charts, and critical-path analysis.

### 🎯 Project Highlights

- 🏗️ Floorplanning, placement, and routed-layout analysis
- ⏱️ Setup WNS and TNS analysis across 16 PVT corners
- 🔍 Hold worst-slack and TNS evaluation
- 📊 Timing comparison charts
- ⚠️ Critical-path investigation and DRC observations

---

## 🔄 1. Physical Design Flow

```text
Synthesis
    ↓
Floorplanning
    ↓
Placement
    ↓
Routing
    ↓
Parasitic Extraction
    ↓
Post-Route STA
    ↓
Timing Analysis
```

---

## 🧰 2. Methodology and STA Inputs

| Input | Purpose |
|---|---|
| `5_route.odb` | Routed OpenDB database |
| `5_route.sdc` | Timing constraints |
| `6_final.spef` | Extracted interconnect parasitics |
| SKY130 HD Liberty `.lib` | Standard-cell timing models |
| `avsddac.lib` | DAC macro timing library |
| `avsdpll.lib` | PLL macro timing library |

**⏱️ Clock constraint:** `11.000 ns`

**📡 Nominal constrained frequency:** Approximately `90.91 MHz`

The clock is defined as:

```tcl
create_clock -name clk -period 11.0000 [get_pins {pll/CLK}]
```

The clock period represents the target constraint, not proof of the achieved operating frequency.

---

## 📊 3. Setup and Hold Results — 16 PVT Corners

All timing values are in nanoseconds. The hold column represents hold worst slack.

| PVT Corner | Setup WNS | Setup TNS | Hold Slack | Hold TNS |
|---|---:|---:|---:|---:|
| `ff_100C_1v65` | 3.27 | 0.00 | 1.50 | 0.00 |
| `ff_100C_1v95` | 6.50 | 0.00 | 3.25 | 0.00 |
| `ff_n40C_1v56` | 9.80 | 0.00 | 5.00 | 0.00 |
| `ff_n40C_1v65` | 6.00 | 0.00 | 0.26 | 0.00 |
| `ff_n40C_1v76` | 10.00 | 0.00 | 0.23 | 0.00 |
| `ff_n40C_1v95` | 8.06 | 0.00 | 0.19 | 0.00 |
| `ss_100C_1v40` | -3.34 | -462.24 | 0.85 | 0.00 |
| `ss_100C_1v60` | 1.29 | 0.00 | 0.64 | 0.00 |
| `ss_n40C_1v28` | **-32.03** | **-15425.60** | 2.75 | 0.00 |
| `ss_n40C_1v35` | -17.90 | -7390.62 | 1.23 | 0.00 |
| `ss_n40C_1v40` | -12.08 | -3942.03 | 3.10 | 0.00 |
| `ss_n40C_1v44` | -8.72 | -2114.08 | 0.95 | 0.00 |
| `ss_n40C_1v60` | -1.00 | -19.01 | 0.65 | 0.00 |
| `ss_n40C_1v76` | 2.52 | 0.00 | 1.85 | 0.00 |
| `tt_025C_1v80` | 6.16 | 0.00 | 0.32 | 0.00 |
| `tt_100C_1v80` | -18.22 | -5588.14 | 0.30 | 0.00 |

### 🔎 Key Observations

- ❌ **7 corners** have negative setup WNS.
- ❌ **6 corners** have negative setup TNS.
- 🔴 Worst setup WNS: **−32.03 ns** at `ss_n40C_1v28`.
- 🔴 Worst setup TNS: **−15425.60 ns** at `ss_n40C_1v28`.
- ✅ All 16 corners report positive hold worst slack.
- ✅ Hold TNS is `0.00 ns` across all supplied corners.

A WNS/TNS summary of zero means no negative slack was reported in that summary; it does not necessarily mean the worst path slack is exactly zero.

---

## ⏱️ 4. Setup Timing Analysis

Setup timing verifies that data reaches the capture register before the required clock edge.

Negative setup slack indicates a timing violation.

### 🔴 Worst Setup Corner: `ss_n40C_1v28`

| Parameter | Reported Value |
|---|---|
| Startpoint | `core.CPU_src1_value_a3[14]$_DFF_P_` |
| Endpoint | `core.CPU_Xreg_value_a4[10][27]$_SDFFE_PP0P_` |
| Data arrival time | 46.45 ns |
| Data required time | 14.42 ns |
| Setup slack | **−32.03 ns — VIOLATED** |

**Slack calculation:**

```text
Slack = Required Time − Arrival Time
      = 14.42 − 46.45
      = −32.03 ns
```

The path contains
