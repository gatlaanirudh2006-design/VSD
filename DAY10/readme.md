# 🚀 VSDIAT | ASIC / VLSI Core Training

## 📘 Module 5: Routing and Physical Verification

> 🎯 **Focus:** Power Distribution Network (PDN), Maze Routing, Design Rule Check (DRC), Global Routing, Detailed Routing, and TritonRoute.

---

## 📌 📖 Module Overview

Module 5 explores the routing stages of the **RTL-to-GDSII physical-design flow**. It explains how placed standard cells are connected through physical metal interconnects and how the resulting layout is checked against manufacturing rules.

### 🎯 Learning Objectives

After completing this module, you should be able to:

- 🧩 Understand maze routing and Lee's algorithm.
- 🔍 Explain the purpose of Design Rule Checking (DRC).
- ⚡ Understand the Power Distribution Network (PDN).
- 🔗 Describe how power straps connect to standard-cell power rails.
- 🌐 Differentiate global routing and detailed routing.
- 🛠️ Understand TritonRoute and its major features.
- 🔌 Explain inter-guide connectivity and metal-layer transitions.
- 📂 Identify important post-route files and reports.
- 🏭 Relate routing to the complete RTL-to-GDSII flow.

---

## 🧭 1. SKY130_D5_SK1 — Routing Fundamentals and DRC

This section introduces routing algorithms and physical-layout verification.

### 🔹 SKY_L1 — Maze Routing Using Lee's Algorithm

Maze routing treats the search for a connection as a path-finding problem on a routing grid.

**📌 Key Topics**
- 🗺️ Routing grids and path exploration
- 📍 Source and destination points
- ➡️ Route expansion and path generation
- 🚧 Obstacles and routing constraints
- 🔗 Finding a continuous path between two points

**💡 Why It Matters**

Lee's algorithm systematically explores a grid to find a connected path between source and destination points. This provides a foundation for understanding how automated routing tools search for physical wire paths.

### 🔹 SKY_L2 — Lee's Algorithm: Key Concepts

This lesson connects the algorithm's basic operation to practical ASIC routing.

**Important Concepts**
- 🔎 Path exploration
- 🔗 Connectivity preservation
- 🗺️ Routing grids
- 🚧 Obstacles and constraints
- 🧵 Route generation

These principles help explain how global and detailed routing tools construct physical connections.

### 🔹 SKY_L3 — Design Rule Check (DRC)

**DRC** verifies whether the physical layout satisfies the manufacturing rules defined by the technology.

**🔍 Common Checks**
- 📏 Minimum metal width
- ↔️ Minimum spacing
- 🧱 Layer-specific restrictions
- 🔩 Via-related rules
- 🏭 Manufacturing constraints

**💡 Why DRC Is Important**

A logically correct design may still contain physical layout violations. DRC identifies geometry that does not satisfy the required technology rules, making it an essential physical-verification step.

---

## ⚡ 2. SKY130_D5_SK2 — Power Distribution and Routing

This section covers power delivery and the main stages of routing.

### 🔹 SKY_L1 — Building the Power Distribution Network

The **Power Distribution Network (PDN)** distributes power and ground throughout the chip.

**📌 Key Components**
- ⚡ VDD and VSS supply networks
- 🔲 Power rings
- ➖ Power straps
- 🔗 Standard-cell power connections
- 🔋 Physical power delivery

**💡 Why It Matters**

Every standard cell requires stable power and ground connections. The PDN provides the physical network that distributes these supplies throughout the design.

### 🔹 SKY_L2 — Connecting Power Straps to Standard-Cell Rails

Power structures must connect to the power rails used by individual standard cells.

**🔄 Power Distribution Hierarchy**

```text
⚡ Power Sources
       |
       v
🔋 Power Distribution Network
       |
       v
➖ Power Rings and Straps
       |
       v
🔗 Standard-Cell VDD/VSS Rails
       |
       v
🧩 Standard Cells
```

**📌 Important Concepts**
- Power straps and rings
- VDD/VSS rails
- Physical power connectivity
- Standard-cell placement and power distribution

### 🔹 SKY_L3 — Global Routing, Detailed Routing, and TritonRoute

Routing is generally divided into two major stages.

#### 🌐 Global Routing

Global routing determines approximate paths and allocates routing resources.

**It considers:**
- 🔗 Net connectivity
- 🗺️ Routing regions
- 📊 Routing capacity
- 🚦 Congestion
- ➡️ Approximate wire paths

#### 🛠️ Detailed Routing

Detailed routing converts routing guidance into specific physical wires and vias while satisfying routing constraints.

**It considers:**
- 📍 Exact wire locations
- 🧱 Metal layers
- 🔩 Via placement
- 🔍 Design rules
- 🔗 Electrical connectivity

#### ⚙️ TritonRoute

**TritonRoute** performs detailed routing in the physical-design flow. It connects placed cells according to the netlist and generates the routed physical representation of the design.

---

## 🚦 3. SKY130_D5_SK3 — TritonRoute Features

This section explores how TritonRoute uses route guides and maintains electrical connectivity.

### 🔹 SKY_L1 — Pre-Processed Route Guides

TritonRoute uses routing guides generated earlier in the routing process.

**📌 Key Concepts**
- 🗺️ Route guides
- 📂 Pre-processed routing information
- ⚙️ Routing constraints
- 🧵 Guide-based detailed routing

**💡 Purpose:** Route guides provide information that helps the detailed router determine where connections should be constructed.

### 🔹 SKY_L2 — Inter-Guide Connectivity and Layer Routing

#### 🔗 Inter-Guide Connectivity

The router must maintain electrical connectivity across different routing-guide regions.

#### ➖ Intra-Layer Routing

Routing within the same metal layer must satisfy:
- Connectivity requirements
- Geometrical constraints
- Design rules

#### 🔀 Inter-Layer Routing

Connections between different metal layers require vias.

```text
🧱 Metal Layer A
       |
       v
     🔩 Via
       |
       v
🧱 Metal Layer B
```

Vias allow signals to transition between metal layers and support complex physical routes.

### 🔹 SKY_L3 — TritonRoute Connectivity Handling

This lesson focuses on preserving electrical connections during detailed routing.

**📌 Key Concepts**
-
