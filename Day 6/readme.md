# 🚀 Day 6 — OpenLane, Open-Source EDA & RTL-to-GDSII

> 🔍 **Focus:** Understanding how an RTL design is transformed into a physical, verified chip layout using an open-source ASIC flow.

---

## 🎯 Day 6 Objective

Day 6 connects the **RTL-level design work** from the previous stages with the actual physical implementation of an ASIC.

The complete journey is studied — starting from a **Verilog/SystemVerilog description** and progressing through synthesis, timing analysis, floorplanning, placement, clock-tree construction, routing, and physical verification until the final **GDSII** layout is produced.

This module introduces:

* 🔓 Open-source EDA tools
* 🏭 Semiconductor foundries
* 📦 Process Design Kits (PDKs)
* 🌊 SkyWater **SKY130**
* ⚙️ OpenLane automation
* 🧠 PicoRV32 processor core
* 📐 Floorplanning and placement
* ⚡ Power planning
* 🕒 Static Timing Analysis
* 🌳 Clock Tree Synthesis
* 🛣️ Routing
* 📊 RC extraction
* ✅ DRC and LVS
* 💾 GDSII generation

---

# 📚 Topics Covered

| #  | Topic                         |
| -- | ----------------------------- |
| 01 | 🔓 Open-Source EDA Ecosystem  |
| 02 | 🏭 Foundries and PDKs         |
| 03 | 🌊 SkyWater SKY130            |
| 04 | ⚙️ OpenLane                   |
| 05 | 🧠 PicoRV32                   |
| 06 | 🔄 Complete RTL-to-GDSII Flow |
| 07 | 🔍 Individual Flow Stages     |
| 08 | 🧰 Tool Reference             |
| 09 | 🏁 Final Summary              |

---

# 1. 🔓 Open-Source EDA Ecosystem

ASIC design traditionally depends heavily on commercial EDA software. Open-source tools provide another way to explore the complete chip-design process without requiring expensive commercial licenses.

Each tool is responsible for a particular part of the flow.

### 🧰 Important Open-Source Tools

| 🔧 Function                             | 🛠️ Tool        |
| --------------------------------------- | --------------- |
| RTL Synthesis                           | **Yosys**       |
| Logic Optimization & Technology Mapping | **ABC**         |
| Static Timing Analysis                  | **OpenSTA**     |
| Physical Design                         | **OpenROAD**    |
| Detailed Routing                        | **TritonRoute** |
| Layout & DRC                            | **Magic**       |
| LVS                                     | **Netgen**      |
| Layout Visualization                    | **KLayout**     |
| DFT-related Operations                  | **Fault**       |

### 🔗 How they work together

```text
RTL
 │
 ▼
Yosys
 │
 ▼
ABC
 │
 ▼
OpenSTA
 │
 ▼
OpenROAD
 │
 ├── Floorplan
 ├── Placement
 ├── CTS
 └── Routing
 │
 ▼
Magic / Netgen
 │
 ▼
GDSII
```

Individually these are separate tools, but when properly connected they form an entire open-source ASIC implementation flow.

**OpenLane** automates this overall process.

---

# 2. 🏭 Foundry & PDK

## 🏗️ What is a Semiconductor Foundry?

A **semiconductor foundry** is the manufacturing facility responsible for fabricating integrated circuits.

The designer creates the physical layout, while the foundry uses that layout to manufacture the actual silicon chip.

### 🔄 Designer → Silicon

```text
👨‍💻 Chip Designer
       ↓
📝 RTL
       ↓
⚙️ EDA Flow
       ↓
📐 Physical Layout
       ↓
💾 GDSII
       ↓
🏭 Foundry
       ↓
🔲 Fabricated Chip
```

The manufacturing technology determines important characteristics such as:

* 🔹 Transistor characteristics
* 🔹 Available metal layers
* 🔹 Design rules
* 🔹 Standard-cell libraries
* 🔹 Manufacturing limitations

---

## 📦 What is a PDK?

**PDK = Process Design Kit**

A PDK provides the information required by EDA tools to design for a particular semiconductor manufacturing process.

### A PDK contains information such as:

* 🧱 Standard-cell libraries
* ⏱️ Timing libraries
* 📐 LEF files
* 💾 GDS files
* ⚡ SPICE models
* 📏 DRC rules
* 🔌 LVS rules
* 📊 RC extraction information

### 🔗 PDK's Role

```text
EDA Tools  ←──── PDK ────→  Manufacturing Process
```

Without the appropriate PDK, the EDA tools would not know the physical and electrical requirements of the target technology.

---

# 3. 🌊 SkyWater & SKY130

**SkyWater Technology**, in collaboration with Google, made its **130 nm SKY130 process** available through an open-source PDK.

This was an important development for open-source silicon because it made it possible to experiment with a real semiconductor process using open-source design tools.

### ⭐ Why SKY130 is useful for learning

* 🔓 Open-source PDK
* 📖 Well documented
* 🧪 Suitable for experimentation
* 🏭 Based on a real manufacturing process
* 🎓 Excellent for learning ASIC implementation

SKY130 is not a modern leading-edge process. However, its openness and maturity make it very useful for understanding the complete ASIC flow.

> 💡 **Important:** "130 nm" refers to the process technology designation. It does **not** mean that every structure on the chip is exactly 130 nm.

---

# 4. ⚙️ OpenLane

## 🔧 What does OpenLane do?

**OpenLane** acts as an automation framework for the open-source ASIC flow.

Instead of manually running every EDA tool and transferring files between stages, OpenLane coordinates the major stages automatically.

### 🔄 Simplified OpenLane Flow

```text
       📝 RTL
         │
         ▼
   ⚙️ Synthesis
         │
         ▼
 🔲 Gate-Level Netlist
         │
         ▼
    📐 Floorplan
         │
         ▼
     📍 Placement
         │
         ▼
       🌳 CTS
         │
         ▼
    🛣️ Routing
         │
         ▼
   🔎 Verification
         │
         ▼
       💾 GDSII
```

The purpose is to take a digital design and move it systematically toward a physical chip layout.

---

# 5. 🧠 PicoRV32 — A Practical Test Design

A simple counter or multiplexer is useful for basic experiments, but a realistic processor provides a much better test of the complete ASIC flow.

**PicoRV32**, developed by **Clifford Wolf**, is a compact **RISC-V RV32 processor core**.

It contains several real digital-design components, including:

* 🧮 ALU
* 🎛️ Control logic
* 📖 Instruction decoder
* 🗃️ Register file
* 🔌 Memory interface

Because of this complexity, PicoRV32 provides a more realistic example for testing synthesis and physical implementation.

### 🧠 Why use PicoRV32?

It demonstrates that the open-source flow is capable of handling more than very small educational circuits.

```text
Processor RTL
      ↓
Synthesis
      ↓
Physical Implementation
      ↓
Verified Layout
```

---

# 6. 🔄 RTL-to-GDSII: The Complete Journey

The entire ASIC flow can be summarized as:

```text
📝 RTL Design
      ↓
⚙️ Synthesis
      ↓
🔲 Gate-Level Netlist
      ↓
🕒 STA
      ↓
📐 Floorplanning
      ↓
⚡ Power Planning
      ↓
📍 Placement
      ↓
🌳 Clock Tree Synthesis
      ↓
✨ Optimization
      ↓
🌐 Global Routing
      ↓
🧵 Detailed Routing
      ↓
📊 RC Extraction
      ↓
🕒 Post-Route STA
      ↓
✅ DRC + LVS
      ↓
💾 GDSII
```

The flow gradually changes the design from a **logical description** into actual **physical geometry**.

---

# 7. 🔍 Stage-by-Stage Explanation

## 7.1 📝 RTL Design

RTL stands for **Register Transfer Level**.

It describes the behavior and structure of digital hardware using languages such as:

* Verilog
* SystemVerilog
* VHDL

At this stage, the design describes **what the hardware should do**, not where its physical components should be placed.

### Example

```verilog
always @(posedge clk)
    q <= d;
```

This represents a register that captures `d` on the active clock edge.

At this point, no physical location for that register has been decided.

---

## 7.2 ⚙️ RTL Synthesis

Synthesis converts the RTL description into a structural gate-level representation.

### 🔹 Yosys

Yosys processes the RTL and generates a structural netlist.

### 🔹 ABC

ABC performs:

* Logic optimization
* Technology mapping

The resulting logic is mapped toward available **SKY130 standard cells**, including:

```text
AND
OR
NAND
NOR
INV
BUF
MUX
Flip-Flops
```

### 🔄 Transformation

```text
RTL
 ↓
Logic Representation
 ↓
Optimized Logic
 ↓
Technology-Mapped Netlist
```

---

# 7.3 🕒 Static Timing Analysis — STA

STA checks whether the design can operate within its specified timing requirements.

Unlike functional simulation, STA analyzes timing paths mathematically rather than executing the design with input vectors.

### 📌 Important Timing Parameters

| Term                | Meaning                                           |
| ------------------- | ------------------------------------------------- |
| **WNS**             | Worst Negative Slack                              |
| **TNS**             | Total Negative Slack                              |
| **Slack**           | Timing margin between required and actual arrival |
| **Critical Path**   | Most timing-sensitive path                        |
| **Setup Violation** | Data arrives too late                             |
| **Hold Violation**  | Data changes too early                            |

### ⏱️ WNS

**Worst Negative Slack** represents the worst timing margin among the analyzed paths.

```text
WNS ≥ 0
   ↓
Timing requirement generally satisfied
```

### 📊 TNS

**Total Negative Slack** represents the sum of negative slack from violating paths.

```text
TNS = 0
   ↓
No negative-slack violations in that category
```

Other important timing concepts include:

* Clock period
* Data arrival time
* Required arrival time
* Setup time
* Hold time
* Critical path

---

# 7.4 📐 Floorplanning

Floorplanning defines the high-level physical organization of the chip.

It determines or establishes:

* 📏 Die dimensions
* ⬜ Core dimensions
* 🧱 Standard-cell area
* 🔌 I/O positions
* ⚡ Power structures

### 🗺️ Basic Floorplan

```text
+--------------------------------+
|              DIE               |
|                                |
|      +------------------+      |
|      |       CORE       |      |
|      |                  |      |
|      | Standard Cells   |      |
|      |                  |      |
|      +------------------+      |
|                                |
+--------------------------------+
```

### ⚠️ Why is floorplanning important?

A poor floorplan can cause problems later with:

* ⏱️ Timing
* 🚦 Congestion
* 🛣️ Routing
* ⚡ Power
* 📐 Area

Therefore, floorplanning strongly influences the quality of the later stages.

---

# 7.5 ⚡ Power Planning

Power planning creates the physical network used to distribute power and ground throughout the chip.

### Main structures

* 🔲 Power rings
* ➖ Power straps
* 🛤️ Standard-cell power rails

The network connects **VDD** and **VSS** to the cells.

### 🎯 Main objective

```text
Stable Power Distribution
          +
Reduced IR Drop
          ↓
Reliable Circuit Operation
```

The goal is to maintain a stable supply voltage throughout the design.

---

# 7.6 📍 Placement

Placement decides where the standard cells will physically reside inside the core.

There are two important stages.

### 🌐 Global Placement

Global placement determines approximate locations for cells while considering:

* Wire length
* Timing
* Congestion
* Area utilization

### 📌 Detailed Placement

Detailed placement takes those approximate positions and makes them physically legal.

```text
Global Placement
       ↓
Approximate Locations
       ↓
Detailed Placement
       ↓
Legal Cell Locations
```

The placement process tries to balance several competing requirements simultaneously.

---

# 7.7 🌳 Clock Tree Synthesis — CTS

A clock signal must reach a large number of flip-flops.

CTS constructs a buffered clock network to distribute the clock with controlled delay and skew.

### 🌳 Simple Clock Structure

```text
              CLK
               │
             Buffer
            /      \
        Buffer    Buffer
        /   \      /   \
       FF   FF    FF   FF
```

### CTS concentrates on:

* ↔️ Clock skew
* ⏱️ Clock delay
* 🔢 Fanout
* 📈 Transition time

The objective is to distribute the clock effectively to sequential elements.

---

# 7.8 🛣️ Routing

Routing establishes the physical interconnections between cells.

There are two major routing stages.

## 🌐 Global Routing

Global routing decides the approximate path and routing resources that each connection should use.

## 🧵 Detailed Routing

Detailed routing creates the actual:

* Metal wires
* Vias
* Layer connections

while respecting technology constraints.

### 📏 Routing must obey rules such as:

* Minimum metal width
* Minimum spacing
* Via restrictions
* Layer requirements

**TritonRoute** is used for detailed routing.

---

# 7.9 📊 RC Extraction

Real interconnects are not ideal.

Physical wires contain:

```text
R → Resistance
C → Capacitance
```

These parasitic values affect signal delay.

### 🔄 Extraction Process

```text
Actual Routed Layout
        ↓
Extract R + C
        ↓
Parasitic Information
        ↓
Accurate Timing Analysis
```

RC extraction therefore makes the timing analysis more realistic.

---

# 7.10 🕒 Post-Route STA

After routing, timing analysis is performed again using the extracted parasitic information.

This provides a more realistic timing picture because actual physical interconnect effects are now included.

```text
Placement / Routing
        ↓
Physical Wires
        ↓
RC Extraction
        ↓
Post-Route STA
        ↓
Realistic Timing Results
```

This is one of the most important timing checks before the design proceeds toward final verification and tapeout.

---

# 7.11 ✅ Physical Verification

The physical layout must satisfy both manufacturing rules and connectivity requirements.

Two major checks are:

## 📏 DRC — Design Rule Check

DRC verifies that the layout obeys the foundry's manufacturing rules.

Examples include:

* Minimum width
* Minimum spacing
* Via rules
* Other geometry constraints

### 🎯 Purpose

```text
Layout
 ↓
Check Manufacturing Rules
 ↓
DRC Result
```

---

## 🔌 LVS — Layout Versus Schematic

LVS checks whether the physical layout represents the same connectivity as the intended gate-level design.

```text
Gate-Level Netlist
        │
        │ Compare
        ▼
Physical Layout
        │
        ▼
     LVS Result
```

### 🛠️ Tools

| Check | Tool       |
| ----- | ---------- |
| DRC   | **Magic**  |
| LVS   | **Netgen** |

---

# 7.12 💾 GDSII Generation

After implementation and verification, the final physical design is exported in **GDSII** format.

GDSII represents the physical layout information required for fabrication.

It contains information describing:

* 🧱 Physical shapes
* 🗂️ Layers
* 🧩 Cells
* 🧵 Interconnections
* 📐 Layout geometry

### 🏁 Final Path

```text
Routing
   ↓
Physical Verification
   ↓
GDSII
   ↓
Tapeout
   ↓
🏭 Fabrication
```

GDSII is therefore the final physical layout representation generated by the flow.

---

# 8. 🧰 Tool Reference

| 🔹 Stage                | 🛠️ Tool            | 🎯 Responsibility                         |
| ----------------------- | ------------------- | ----------------------------------------- |
| RTL Synthesis           | **Yosys**           | Converts RTL to gate-level representation |
| Logic Optimization      | **ABC**             | Optimization and technology mapping       |
| Timing Analysis         | **OpenSTA**         | Static timing verification                |
| Physical Implementation | **OpenROAD**        | Floorplan, placement and physical design  |
| CTS                     | **OpenROAD / CTS**  | Builds the clock network                  |
| Global Routing          | **OpenROAD**        | Determines approximate routes             |
| Detailed Routing        | **TritonRoute**     | Creates physical wires and vias           |
| RC Extraction           | **OpenRCX**         | Extracts parasitic R and C                |
| DRC                     | **Magic**           | Checks design rules                       |
| LVS                     | **Netgen**          | Compares layout and netlist               |
| Layout Viewer           | **KLayout / Magic** | Visualizes the layout                     |
| Final Output            | **—**               | GDSII                                     |

---

# 🏁 9. Final Takeaways

Day 6 brings together the concepts of **digital design, synthesis, timing analysis and physical implementation**.

The most important flow to remember is:

```text
📝 RTL
 ↓
⚙️ Synthesis
 ↓
🔲 Netlist
 ↓
🕒 STA
 ↓
📐 Floorplan
 ↓
⚡ Power Plan
 ↓
📍 Placement
 ↓
🌳 CTS
 ↓
🛣️ Routing
 ↓
📊 RC Extraction
 ↓
🕒 Post-Route STA
 ↓
✅ DRC + LVS
 ↓
💾 GDSII
 ↓
🏭 Fabrication
```

### 💡 Core Idea

**RTL is only the beginning.**

The RTL describes the intended behavior of the hardware, but the remaining stages determine how that logic becomes a real physical chip.

Throughout the flow:

* ⚙️ Technology mapping determines which cells implement the logic.
* 📐 Floorplanning determines the physical organization.
* 📍 Placement determines where cells are located.
* 🌳 CTS distributes the clock.
* 🛣️ Routing creates physical connections.
* 📊 RC extraction captures wire parasitics.
* 🕒 STA checks timing.
* 📏 DRC checks manufacturing rules.
* 🔌 LVS checks connectivity.
* 💾 GDSII represents the final physical layout.

Therefore, decisions made during RTL design can eventually influence **area, timing, congestion and power** in the final chip.

---

## ⭐ Day 6 in One Sentence

> **🧠 RTL defines the hardware → ⚙️ EDA tools implement it → 📐 physical design creates the layout → ✅ verification validates it → 💾 GDSII represents the final chip.**

---

