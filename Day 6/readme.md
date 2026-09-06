# 🔷 Day 6 – Open-Source EDA, OpenLane & RTL-to-GDSII Flow

## 🎯 Objective

Day 6 shifts from individual RTL and synthesis exercises to the complete ASIC implementation process.

The session explains semiconductor foundries and PDKs, SKY130, OpenLane, synthesis, STA, floorplanning, placement, CTS, routing, and physical verification.

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

Traditionally, ASIC development has depended on costly proprietary EDA software.

Open-source tools provide an alternative where the complete design process can be explored without commercial licenses.

---

# 2️⃣ Foundries and PDKs

A semiconductor foundry handles the manufacturing process.

A PDK connects the design tools with a particular fabrication technology.

---

# 3️⃣ SkyWater & SKY130

SkyWater Technology, along with Google, released its 130nm process (SKY130) as an open-source PDK.

---

# 4️⃣ OpenLane

OpenLane brings the individual open-source tools together into a unified scripted flow.

---

# 5️⃣ PicoRV32 as a Realistic Test Design

PicoRV32 is a compact RISC-V RV32 processor core.

---

# 6️⃣ Complete RTL-to-GDSII Flow

📄 RTL Design  
↓  
⚙️ RTL Synthesis  
↓  
📋 Gate-Level Netlist  
↓  
⏱️ Static Timing Analysis  
↓  
📐 Floorplanning  
↓  
⚡ Power Planning  
↓  
📍 Placement  
↓  
🌳 Clock Tree Synthesis  
↓  
🛣️ Routing  
↓  
🔍 Physical Verification  
↓  
📦 GDSII

---

# 7️⃣ Stage-by-Stage Breakdown

## 📄 RTL Design

RTL represents the behavior or structure of hardware using an HDL.

---

## ⚙️ RTL Synthesis

Yosys transforms behavioral RTL into a structural netlist.

---

## ⏱️ Static Timing Analysis (STA)

STA determines whether signal paths remain within their required timing limits.

---

## 📐 Floorplanning

Floorplanning defines the chip's overall physical arrangement.

---

## ⚡ Power Planning

Power planning establishes the power and ground distribution network.

---

## 📍 Placement

Global placement determines approximate cell locations.

Detailed placement adjusts and legalizes those locations.

---

## 🌳 Clock Tree Synthesis (CTS)

CTS constructs a buffered clock-distribution network.

---

## 🛣️ Routing

Global routing establishes approximate wiring paths.

Detailed routing produces the actual physical wires and vias.

---

## 📏 RC Extraction

RC extraction obtains parasitic resistance and capacitance values from the routed geometry.

---

## ⏱️ Post-Route STA

Timing analysis is performed again using the extracted parasitics.

---

## 🔍 Physical Verification

DRC checks manufacturing rules.

LVS checks whether the physical layout corresponds to the intended netlist.

---

## 📦 GDSII Generation

The final verified layout is exported as a GDSII file.

---

# 8️⃣ Tools Reference

| Stage | Tool | Function |
|---|---|---|
| ⚙️ RTL Synthesis | Yosys | RTL → gate-level netlist |
| 🔧 Logic Optimization | ABC | Optimization + technology mapping |
| ⏱️ Static Timing Analysis | OpenSTA | Timing verification |
| 📐 Physical Design | OpenROAD | Floorplan, placement, physical implementation |
| 🌳 Clock Tree Synthesis | OpenROAD / CTS | Clock network construction |
| 🗺️ Global Routing | OpenROAD | Approximate wiring paths |
| 🛣️ Detailed Routing | TritonRoute | Physical wires and vias |
| 📏 RC Extraction | OpenRCX | Parasitic extraction |
| 🔍 DRC | Magic | Design-rule checking |
| 🔗 LVS | Netgen | Layout-vs-schematic checking |
| 👁️ Layout Viewing | KLayout / Magic | Visual inspection |
| 📦 Final Output | — | GDSII |

---

# 9️⃣ Conclusion

Day 6 brings together RTL-level activities with the physical side of chip manufacturing.
