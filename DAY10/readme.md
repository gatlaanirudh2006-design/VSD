# 🚀 VSDIAT – ASIC / VLSI Core Training

## 📘 Module 5: Routing and Physical Verification

### 🎯 Overview

Module 5 focuses on the final routing stages of the **RTL-to-GDSII physical-design flow**. It covers maze routing, Lee's algorithm, Design Rule Check (DRC), Power Distribution Network (PDN), global routing, detailed routing, and TritonRoute.

The module explains how placed standard cells are connected through physical interconnects and how the routed layout is checked against manufacturing constraints.

---

## 🎯 Learning Objectives

- 🧩 Understand maze routing and Lee's algorithm.
- 🔍 Learn the importance of Design Rule Checking (DRC).
- ⚡ Understand PDN construction and power distribution.
- 🔗 Study connections between power straps and standard-cell rails.
- 🌐 Differentiate global routing from detailed routing.
- 🛠️ Understand TritonRoute and its important features.
- 🔀 Learn about route guides, vias, and metal-layer connectivity.
- 📂 Identify post-route files and reports.

---

## 🧭 1. SKY130_D5_SK1 — Routing and DRC

### 🔹 SKY_L1: Maze Routing — Lee's Algorithm

Maze routing treats routing as a path-finding problem on a grid.

**Key concepts:**
- Source and destination points
- Grid-based path exploration
- Route generation and connectivity
- Obstacles and routing constraints

Lee's algorithm systematically searches a routing grid to find a connected path between two points.

### 🔹 SKY_L2: Lee's Algorithm Conclusion

This lesson connects routing algorithms with practical physical design.

Important concepts include path exploration, routing grids, connectivity, obstacles, and route generation. These principles help explain automated routing tools.

### 🔹 SKY_L3: Design Rule Check (DRC)

DRC verifies that the physical layout follows the manufacturing rules defined by the technology.

**Common checks:**
- Minimum metal width and spacing
- Layer-specific restrictions
- Via-related rules
- Metal geometry constraints

**💡 Importance:** A logically correct design may still violate manufacturing rules. DRC helps identify physical-layout violations before fabrication.

---

## ⚡ 2. SKY130_D5_SK2 — PDN and Routing

### 🔹 SKY_L1: Build the Power Distribution Network

The **Power Distribution Network (PDN)** distributes power and ground throughout the chip.

**Key components:**
- VDD and VSS networks
- Power rings and straps
- Standard-cell power rails
- Physical power connections

A properly constructed PDN provides the supply connections required by standard cells.

### 🔹 SKY_L2: Power Straps to Standard-Cell Rails

Power straps connect higher-level power structures to the power rails of standard cells.

```text
Power Sources
     ↓
Power Distribution Network
     ↓
Power Rings / Straps
     ↓
Standard-Cell VDD/VSS Rails
     ↓
Standard Cells
```

### 🔹 SKY_L3: Global Routing and Detailed Routing

**🌐 Global Routing**

Determines approximate routing paths and allocates routing resources based on connectivity, congestion, and routing capacity.

**🛠️ Detailed Routing**

Creates the actual physical wires and vias while satisfying routing constraints and design rules.

**⚙️ TritonRoute**

TritonRoute performs detailed routing by connecting placed cells according to the design netlist and generating the routed physical representation.

---

## 🚦 3. SKY130_D5_SK3 — TritonRoute Features

### 🔹 SKY_L1: Pre-Processed Route Guides

TritonRoute uses route guides generated earlier in the routing flow to determine where connections should be routed.

### 🔹 SKY_L2: Inter-Guide Connectivity and Layer Routing

**Inter-guide connectivity:** Maintains electrical connections across different routing-guide regions.

**Intra-layer routing:** Creates connections within the same metal layer while respecting geometry and design rules.

**Inter-layer routing:** Connects different metal layers using vias.

```text
Metal Layer A
     ↓
    Via
     ↓
Metal Layer B
```

### 🔹 SKY_L3: Connectivity Handling

TritonRoute must preserve the intended electrical connections during detailed routing.

Important concepts include:
- Net and guide connectivity
- Routing topology
- Via insertion
- Metal-layer transitions
- Connectivity verification

### 🔹 SKY_L4: Routing Topology and Post-Route Files

This lesson covers the physical route structure and the data generated after routing.

**Typical outputs and information:**
- Routed DEF
- Routing reports
- Post-route physical data
- Physical-verification information

These outputs support further analysis and verification of the routed design.

---

## 🔄 4. Routing Flow

```text
Placed Design
     ↓
Power Distribution Network
     ↓
Global Routing
     ↓
Route Guides
     ↓
Detailed Routing (TritonRoute)
     ↓
DRC / Physical Verification
     ↓
Post-Route Design
```

---

## 🏭 5. RTL-to-GDSII Flow

```text
RTL Design
    ↓
Synthesis
    ↓
Floorplanning
    ↓
Power Planning
    ↓
Placement
    ↓
Clock Tree Synthesis (CTS)
    ↓
Global Routing
    ↓
Detailed Routing
    ↓
Physical Verification
    ↓
GDSII
```

Module 5 focuses on the routing and verification stages near the end of this process.

---

## 📚 6. Important Concepts Summary

| Topic | Description |
|---|---|
| 🧩 Maze Routing | Grid-based path finding |
| 🧮 Lee's Algorithm | Systematic routing search |
| 🔍 DRC | Manufacturing-rule verification |
| ⚡ PDN | VDD/VSS power distribution |
| 🌐 Global Routing | Approximate paths and resource allocation |
| 🛠️ Detailed Routing | Physical wires and vias |
| 🧭 Route Guides | Guidance for detailed routing |
| ⚙️ TritonRoute | Detailed-routing tool |
| 🔗 Connectivity | Maintaining electrical connections |
| 📂 Post-Route Data | Routed files and reports |

---

## ✅ 7. Module Completion Checklist

- [ ] SKY130_D5_SK1 — Routing and DRC
- [ ] Maze routing and Lee's algorithm
- [ ] Design Rule Check concepts
- [ ] SKY130_D5_SK2 — PDN and routing
- [ ] Power straps and standard-cell rails
- [ ] Global and detailed routing
- [ ] TritonRoute features
- [ ] Route guides and connectivity
- [ ] Intra-layer and inter-layer routing
- [ ] Routing topology and post-route files

---

## 🧠 8. Skills Developed

- **🏗️ Physical Design:** PDN, DRC, and physical verification
- **🧩 Routing Algorithms:** Maze routing and Lee's algorithm
- **🌐 Routing Techniques:** Global and detailed routing
- **⚙️ Tools:** TritonRoute and the RTL-to-GDSII flow
- **🔌 ASIC Concepts:** Power delivery, vias, connectivity, and post-route data

---

## 🏁 Conclusion

Module 5 brings together routing algorithms, power distribution, TritonRoute, and DRC to explain the final routing-focused stages of VSDIAT physical-design training.

These concepts demonstrate how a placed and clocked design is converted into a physically routed implementation that can proceed through physical verification.

---

**🎓 Training:** VSDIAT – ASIC / VLSI Core Training  
**📌 Module:** 5 – Routing and Physical Verification with TritonRoute
