# 🚀 VSDBabySoC SKY130 HD — Post-Route Static Timing Analysis

## 📘 Overview
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

The path contains combinational logic that contributes to the late data arrival under this timing model.

### 📉 Setup Analysis Summary

The setup WNS and TNS charts in the accompanying PDF show significant violations in several slow-slow corners, particularly `ss_n40C_1v28`, `ss_n40C_1v35`, `ss_n40C_1v40`, and `ss_n40C_1v44`.

Further investigation of cell delays, net delays, clock timing, constraints, and timing exceptions is required to identify the root cause.

---

## 🟢 5. Hold Timing Analysis

Hold timing checks that data does not arrive too early after the capture clock edge.

### Key Results

- ✅ All 16 reported hold worst-slack values are positive.
- 📉 Minimum hold worst slack: **0.19 ns** at `ff_n40C_1v95`.
- 📊 Hold TNS: **0.00 ns** across all 16 corners.

Positive hold slack indicates that the supplied hold checks pass. However, passing hold timing does not compensate for setup violations.

---

## 🏗️ 6. Physical-Design Evidence

The accompanying PDF includes:

1. 📐 Floorplan and DAC macro view
2. 🔗 Detailed routing around the PLL macro
3. 🧩 Routed-design overview
4. ⏱️ STA terminal summary
5. 🖥️ OpenROAD GUI detailed view

These figures provide visual evidence of the physical implementation. Timing closure and physical verification must still be confirmed using the corresponding STA and DRC reports.

---

## ⚠️ 7. DRC Findings and Limitations

### 🔍 Reported DRC Observation

The PDF notes **19 detailed-routing DRC entries categorized as “Short” near the DAC macro boundary**.

These entries should be checked against the current DRC report to confirm their status.

### ⚠️ Analysis Limitations

- The reported timing values should be verified against the original per-corner logs.
- The same SPEF across Liberty runs does not represent separate extracted RC corners for each PVT condition.
- The available results do not establish complete path coverage, constraint correctness, or signoff readiness.

### 🛠️ Recommended Next Steps

1. Inspect the complete worst setup path and cell/net delay breakdown.
2. Verify clock definitions, input/output delays, uncertainty, exceptions, and path groups.
3. Use appropriate corner-specific parasitics where supported.
4. Investigate the reported DRC entries near the DAC macro boundary.
5. Optimize the design and rerun STA and DRC.
6. Preserve scripts, logs, constraints, libraries, and extraction details.

---

## 🏁 Conclusion

The 16-corner post-route STA analysis of VSDBabySoC shows significant setup violations, with the worst result at `ss_n40C_1v28` (**WNS = −32.03 ns, TNS = −15425.60 ns**).

Hold timing passes across all supplied corners, but setup violations remain unresolved. Therefore, **timing closure and signoff readiness cannot yet be claimed**.

Further timing optimization, report validation, and physical verification are required.

---

## 🛠️ Tools and Technologies

- **Design:** VSDBabySoC
- **Technology:** SKY130 HD standard-cell library
- **Tools:** OpenROAD / OpenSTA
- **Formats:** Liberty (`.lib`), SDC, ODB, SPEF
- **Analysis:** Post-route setup and hold STA across 16 PVT corners

**🎓 Prepared by:** Anirudh  
**🆔 Roll Number:** `24EG104A59`
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
