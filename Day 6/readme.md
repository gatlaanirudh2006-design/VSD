# 🔷 Day 6 – Open-Source EDA, OpenLane & RTL-to-GDSII Flow

## 🎯 Objective

Day 6 moves beyond individual RTL and synthesis exercises and focuses on the complete ASIC implementation journey — beginning with a Verilog description and progressing towards a manufacturable GDSII layout using open-source tools.

This session covers semiconductor foundries and PDKs, the importance of SkyWater's SKY130 process in open-source silicon, how OpenLane connects different tools into an automated flow, and the purpose of synthesis, STA, floorplanning, placement, CTS, routing, and physical verification.

---

## 📑 Contents

1. 🔹 Open-Source EDA Ecosystem
2. 🔹 Foundries and PDKs
3. 🔹 SkyWater & SKY130
4. 🔹 OpenLane
5. 🔹 PicoRV32 as a Realistic Test Design
6. 🔹 Complete RTL-to-GDSII Flow
7. 🔹 Stage-by-Stage Breakdown
8. 🔹 Tools Reference
9. 🔹 Conclusion

---

# 1️⃣ Open-Source EDA Ecosystem

Earlier ASIC development mainly relied on costly proprietary EDA software. Open-source alternatives allow the complete design flow to be studied and experimented with without requiring commercial licenses.

| **Purpose** | **Open-Source Tool** |
|---|---|
| ⚙️ RTL Synthesis | Yosys |
| 🔧 Logic optimization / tech mapping | ABC |
| ⏱️ Static Timing Analysis | OpenSTA |
| 📐 Physical design (floorplan, placement, etc.) | OpenROAD |
| 🛣️ Detailed routing | TritonRoute |
| 🔍 Layout, DRC, physical verification | Magic |
| 🔗 LVS | Netgen |
| 👁️ Layout viewing | KLayout |
| 🧪 DFT-related work | Fault |

When these tools are connected properly, they provide a complete license-free RTL-to-GDSII pipeline, which is automated by OpenLane.

---

# 2️⃣ Foundries and PDKs

A **semiconductor foundry** is responsible for manufacturing the chip. It takes the physical layout prepared by the designer and fabricates the chip according to a particular process. This process defines transistor characteristics, available metal layers, design rules, and standard-cell options.

```text
👨‍💻 Chip Designer → RTL → EDA Flow → Physical Layout → GDSII → 🏭 Foundry → Fabricated Chip
