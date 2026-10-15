# 🚀 VSDBabySoC — Physical Design & Routed Static Timing Analysis

## 📘 Overview

This project documents the physical-design flow and post-route **Static Timing Analysis (STA)** of **VSDBabySoC** using the **Sky130 HD standard-cell library**.

The report covers floorplanning, placement, routing, extracted interconnect parasitics, and independent timing analysis across **16 Sky130 HD PVT library corners**. Screenshots and timing observations are provided in the accompanying report.

### 🎯 Project Objectives

- 📐 Understand the floorplanning and placement stages.
- 🔗 Examine the final routed physical design.
- ⏱️ Analyze setup and hold timing.
- 📊 Compare timing results across 16 library corners.
- 🔍 Identify timing violations and evaluate the reported results.

---

## 🔄 1. Physical Design Flow

```text
RTL / Synthesized Design
          ↓
     Floorplanning
          ↓
       Placement
          ↓
        Routing
          ↓
 Parasitic Extraction
          ↓
    Post-route STA
          ↓
   Timing Evaluation
```

---

## 🏗️ 2. Physical Design Stages

### 🔹 Floorplanning

Floorplanning establishes the core area and initial physical organization of the design.

**📌 Report observations**
- OpenROAD `2_floorplan` stage
- PLL and DAC macro instances
- PLL instance with placement status `LOCKED`

### 🔹 Placement

Placement assigns standard cells to legal locations while considering timing, congestion, and wirelength.

**📌 Report observations**
- OpenROAD `3_place` view
- Standard-cell placement
- Estimated placement-stage parasitics

*Note:* Placement-stage parasitics differ from extracted parasitics obtained after routing.

### 🔹 Routing

Routing creates physical metal wires and vias to connect placed cells and macros.

The final routed database and extracted parasitics are used for post-route timing analysis.

---

## 📂 3. Post-route STA Inputs

| Input File | Purpose |
|---|---|
| `6_final.odb` | Final routed OpenDB database |
| `6_final.spef` | Extracted interconnect parasitics |
| `5_route.sdc` | Route-stage timing constraints |
| Sky130 HD Liberty `.lib` files | Cell timing models for individual analysis runs |

**⏱️ Clock period:** `11.000 ns`

The report uses propagated clock timing.

---

## 📊 4. Setup Timing Analysis — 16 PVT Corners

Setup timing was evaluated through separate runs, with one Sky130 HD Liberty library corner used per run.

### ⚠️ Key Results

| Library Corner | WNS | TNS | Observation |
|---|---:|---:|---|
| `ss_n40C_1v28` | −32.03 ns | −15425.64 ns | ❌ Setup violation |
| `ss_100C_1v40` | −3.34 ns | −462.24 ns | ❌ Setup violation |
| Other reported corners | 0.00 ns in summary | 0.00 ns in summary | No negative setup slack reported |

**📌 Important:** A WNS/TNS summary of `0.00` means no negative slack was reported in that summary. It does not mean the worst path slack is necessarily zero.

### 🔍 Example: Worst Setup Path

For the `ss_n40C_1v28` corner, the report identifies a register-to-register path in the CPU logic.

| Parameter | Reported Value |
|---|---|
| Startpoint | `core.CPU_src1_value_a3[14]` |
| Endpoint | `core.CPU_Xreg_value_a4[10][27]` |
| Data arrival time | 46.45 ns |
| Data required time | 14.42 ns |
| Slack | **−32.03 ns — VIOLATED** |

**Slack calculation:**

```text
Slack = Required Time − Arrival Time
      = 14.42 − 46.45
      = −32.03 ns
```

The path contains multiple combinational cells, contributing to late data arrival under the slow, low-voltage timing model.

---

## ⏱️ 5. Hold Timing Analysis

The supplied hold reports show positive worst hold-path slack and status **MET** for all 16 analyzed corners.

### 🔹 Example: `ss_n40C_1v35`

| Parameter | Reported Value |
|---|---:|
| Data arrival time | 4.38 ns |
| Data required time | 3.17 ns |
| Hold slack | **+1.21 ns — MET** |

**📌 Observation:** Hold WNS/TNS values of zero indicate that no negative hold slack was reported in the summary. Worst hold-path slack should be evaluated separately.

---

## 📈 6. Results and Observations

- 🏗️ Floorplanning, placement, and routing stages are documented.
- ⏱️ Hold timing is reported as passing across all 16 analyzed corners.
- ⚠️ Setup violations remain in several slow-slow corners.
- 🔴 The most severe reported setup result occurs at `ss_n40C_1v28`.
- 🔍 Timing results should be validated before making signoff claims.

### ⚠️ Timing Validation

**Timing closure cannot be claimed from the supplied results alone.**

Before treating the results as signoff-quality data, verify that every run used the intended:

- Liberty timing library
- Routed ODB database
- Extracted SPE
