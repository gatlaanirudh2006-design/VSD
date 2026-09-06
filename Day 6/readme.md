🚀 Day 6 — From RTL to a Fabricable Chip with Open-Source EDA

Theme: Understanding how a hardware description becomes a physical IC layout using OpenLane + SKY130.

🎯 What This Day Covers

Day 6 moves beyond writing RTL and looking at synthesis results. The focus is the complete ASIC implementation journey: starting with Verilog/SystemVerilog RTL and ending with a verified GDSII layout that can be handed to a semiconductor foundry.

The topics include:

🧰 Open-source EDA tools and their individual roles

🏭 Semiconductor foundries and Process Design Kits (PDKs)

🔬 SkyWater's SKY130 technology

⚙️ OpenLane as an automated RTL-to-GDSII framework

🧠 PicoRV32 as a realistic processor design

📐 Floorplanning, power planning and placement

🕒 Static Timing Analysis and timing metrics

🌳 Clock Tree Synthesis

🛣️ Global and detailed routing

📏 RC extraction and post-route timing

✅ DRC and LVS physical verification

💾 Final GDSII generation

🗺️ Roadmap

🔓 Open-source EDA environment

🏭 Foundry + PDK fundamentals

🌊 SkyWater SKY130

⚙️ OpenLane automation

🧠 PicoRV32 example

🔄 Complete RTL-to-GDSII journey

🔍 Detailed explanation of every stage

🧰 Tool-to-stage mapping

🏁 Final takeaways

1️⃣ Open-Source EDA: The Toolchain

Traditional ASIC development commonly relies on commercial EDA suites. Open-source projects provide an alternative that allows the complete learning flow to be explored without requiring a commercial license.

🧩 Major Tools and Their Jobs

🔧 Activity

🛠️ Open-Source Tool

🎯 Main Role

RTL synthesis

Yosys

Converts RTL into a gate-level representation

Logic optimization

ABC

Optimizes logic and performs technology mapping

Timing analysis

OpenSTA

Checks timing constraints and path delays

Physical implementation

OpenROAD

Handles floorplanning, placement and other physical tasks

Detailed routing

TritonRoute

Produces detailed wires and vias

Layout / DRC

Magic

Layout inspection and design-rule checking

LVS

Netgen

Compares layout connectivity with the intended netlist

Layout visualization

KLayout

Opens and inspects physical layouts

DFT work

Fault

Supports design-for-test related activities

🔗 When these utilities are connected in the correct sequence, they provide the ingredients for a complete open RTL-to-GDSII flow. OpenLane brings these stages together and automates their execution.

2️⃣ 🏭 Foundry and PDK — The Manufacturing Connection

A semiconductor foundry is the manufacturing facility that turns a chip's physical layout into an actual silicon device.

The designer does not directly send Verilog to the factory. The RTL must first pass through synthesis and physical implementation until a manufacturing-ready layout is produced.

🔄 Basic Relationship

👨‍💻 Designer
     │
     ▼
📝 RTL Description
     │
     ▼
⚙️ EDA Implementation
     │
     ▼
📐 Physical Layout
     │
     ▼
💾 GDSII
     │
     ▼
🏭 Foundry
     │
     ▼
🔲 Fabricated Silicon

📦 What is a PDK?

A Process Design Kit (PDK) connects the EDA environment to a particular semiconductor manufacturing technology.

It provides the information needed by the tools, including:

🧱 Standard-cell information

⏱️ Timing libraries

📐 LEF and GDS data

⚡ SPICE device models

📏 DRC/LVS rules

🔌 RC extraction information

Without the PDK, the tools would not know the physical characteristics and manufacturing constraints of the target process.

3️⃣ 🌊 SkyWater and the SKY130 Technology

SkyWater Technology, together with Google, made its 130 nm SKY130 process available through an open-source PDK.

This is important for education and experimentation because it allows designers to study a real, manufacturable semiconductor process using an open toolchain rather than relying only on a simplified or imaginary technology.

⭐ Why SKY130?

🔓 Open technology ecosystem

📚 Well documented

🧪 Suitable for experimentation

🏗️ Mature manufacturing process

🎓 Useful for learning the complete ASIC flow

Note: The term 130 nm identifies the process technology. It does not mean that every physical feature on the chip is literally 130 nm wide.

4️⃣ ⚙️ OpenLane — The Automation Layer

Running every EDA program independently would require many manual commands and careful handoff of files between stages.

OpenLane acts as the automation framework that connects the major stages into a repeatable flow.

🔁 Simplified OpenLane Pipeline

📝 RTL
  ↓
⚙️ Synthesis
  ↓
🔲 Gate-Level Netlist
  ↓
📐 Floorplan
  ↓
📍 Placement
  ↓
🌳 CTS
  ↓
🛣️ Routing
  ↓
🔎 Physical Verification
  ↓
💾 GDSII

The framework therefore turns a digital RTL design into a physical layout while coordinating the required tools.

5️⃣ 🧠 PicoRV32 — A More Realistic Design

For a full-flow demonstration, a design more meaningful than a simple counter is useful.

PicoRV32, created by Clifford Wolf, is a compact RISC-V RV32 processor core. It contains enough real digital logic to exercise synthesis and physical implementation.

Its logic includes areas such as:

🧮 ALU operations

🎛️ Control logic

📖 Instruction decoding

🗃️ Register file

🔌 Memory interface

Because it is a genuine processor core, it gives a better indication of how the open-source flow behaves on a non-trivial design.

6️⃣ 🔄 Complete RTL → GDSII Journey

The complete sequence can be viewed as follows:

📝 RTL Design
      ↓
⚙️ RTL Synthesis
      ↓
🔲 Gate-Level Netlist
      ↓
🕒 Static Timing Analysis
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
🛣️ Global Routing
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

The important idea is that the flow gradually moves from logical behavior to actual physical geometry.

7️⃣ 🔍 Understanding Each Implementation Stage

7.1 📝 RTL Design

RTL describes the intended hardware behavior using languages such as Verilog, SystemVerilog or VHDL.

At this point, the designer is describing functionality rather than physical dimensions or transistor locations.

Example

always @(posedge clk)
    q <= d;

This describes a register. The RTL itself does not specify where that register will physically sit on the chip.

7.2 ⚙️ RTL Synthesis

Synthesis transforms the behavioral RTL into a structural representation.

Main responsibilities

Yosys

Reads and processes the RTL

Builds the structural logic

ABC

Optimizes the logic

Performs technology mapping

The result is a gate-level design mapped toward available SKY130 standard cells, such as:

AND / OR gates

NAND / NOR gates

Inverters

Buffers

Multiplexers

Flip-flops

7.3 🕒 Static Timing Analysis (STA)

STA evaluates whether signal paths can satisfy their timing requirements without performing traditional functional simulation.

📌 Important Timing Terms

Metric

Meaning

WNS

Worst Negative Slack — the most negative timing margin

TNS

Total Negative Slack — combined negative slack from violating paths

Slack

Difference between required and actual arrival time

Critical path

Path with the most difficult timing requirement

Setup violation

Data arrives too late before the clock edge

Hold violation

Data changes too early after the clock edge

Generally:

WNS ≥ 0  →  timing requirement is satisfied
TNS = 0  →  no negative-slack violations in that category

Clock period, data arrival time and required arrival time are also central to STA.

7.4 📐 Floorplanning

Floorplanning establishes the chip's high-level physical organization.

It decides or influences:

📏 Die dimensions

⬜ Core dimensions

🧱 Standard-cell region

🔌 I/O locations

⚡ Power distribution structure

🗺️ Conceptual Floorplan

+--------------------------------------+
|                DIE                   |
|                                      |
|       +------------------------+     |
|       |         CORE           |     |
|       |                        |     |
|       |     Standard Cells     |     |
|       |                        |     |
|       +------------------------+     |
|                                      |
+--------------------------------------+

A poor floorplan can create problems later in:

⏱️ Timing

🛣️ Routing

🚦 Congestion

⚡ Power

📐 Area utilization

Therefore, floorplanning has a strong influence on the rest of the implementation.

7.5 ⚡ Power Planning

Power planning creates the network that distributes supply and ground across the chip.

Typical structures include:

🔲 Power rings

➖ Power straps

🧱 Standard-cell rails

The goal is to deliver VDD/VSS reliably while reducing supply-voltage variation and IR drop.

7.6 📍 Placement

Placement determines where the standard cells are physically located.

Two major phases

🌐 Global Placement

Finds approximate cell positions

Attempts to balance area, timing, wire length and congestion

📌 Detailed Placement

Converts the approximate positions into legal physical locations

Ensures cells occupy valid placement sites

The placement process must balance several competing goals rather than optimizing only one parameter.

7.7 🌳 Clock Tree Synthesis (CTS)

A clock signal has to reach many sequential elements. CTS builds a buffered clock distribution network so that clock arrival is controlled across the design.

🌲 Simple Clock Tree

              CLOCK
                │
              Buffer
             /      \
        Buffer      Buffer
        /   \       /   \
       FF   FF     FF   FF

CTS focuses on factors such as:

🕒 Clock delay

↔️ Clock skew

🔢 Fanout

📈 Transition time

The objective is to distribute the clock in a controlled and balanced manner.

7.8 🛣️ Routing

Routing connects placed cells using physical metal interconnect.

🌐 Global Routing

Determines approximate routes and resources that the connections will use.

🧵 Detailed Routing

Creates the actual physical wires and vias while following technology rules for:

📏 Minimum width

↔️ Spacing

🔩 Via placement

🧱 Layer constraints

TritonRoute is used for detailed routing in the open-source flow.

7.9 📊 RC Extraction

Physical wires are not ideal connections. They contain:

R → Resistance

C → Capacitance

These parasitic components introduce additional delay.

RC extraction obtains these values from the actual routed geometry so that later timing analysis can use more realistic interconnect information.

7.10 🕒 Post-Route STA

After routing and RC extraction, timing is checked again.

This analysis is more representative of the final physical implementation because the timing calculation now includes parasitic effects associated with the actual routed wires.

Before Routing
     ↓
Estimated Interconnect
     ↓
Placement / Routing
     ↓
RC Extraction
     ↓
Post-Route STA
     ↓
More Realistic Timing

7.11 ✅ Physical Verification

Before fabrication, the physical layout must be checked against manufacturing and connectivity requirements.

📏 DRC — Design Rule Check

DRC verifies that the layout follows the foundry's physical rules, including:

Minimum metal width

Required spacing

Via constraints

Other manufacturing geometry rules

🔌 LVS — Layout Versus Schematic

LVS checks whether the connectivity represented by the physical layout matches the intended gate-level netlist.

       Gate-Level Netlist
               │
               │ compare
               ▼
        Physical Layout
               │
               ▼
           LVS Result

In the open-source flow, Magic is used for DRC and Netgen for LVS.

7.12 💾 GDSII Generation

Once the physical design has passed the required checks, the layout can be exported as GDSII.

GDSII contains the physical geometry required to describe the chip layout, including:

🧱 Shapes

🧩 Cells

🗂️ Layers

🧵 Interconnect geometry

Final Direction

Routing
   ↓
Physical Verification
   ↓
GDSII
   ↓
Tapeout
   ↓
🏭 Fabrication

GDSII is therefore the final physical representation produced before the design moves toward manufacturing.

8️⃣ 🧰 Open-Source Tool Reference

🔹 Flow Stage

🛠️ Tool

📌 Purpose

RTL Synthesis

Yosys

RTL → gate-level netlist

Logic Optimization

ABC

Logic optimization + technology mapping

STA

OpenSTA

Timing verification

Physical Design

OpenROAD

Floorplanning, placement and implementation

CTS

OpenROAD / CTS

Clock network generation

Global Routing

OpenROAD

Approximate routing paths

Detailed Routing

TritonRoute

Physical wires and vias

RC Extraction

OpenRCX

Parasitic extraction

DRC

Magic

Design-rule verification

LVS

Netgen

Layout/netlist comparison

Layout Viewing

KLayout / Magic

Physical layout inspection

Final Output

—

GDSII

🏁 9️⃣ Final Takeaway

Day 6 ties together the concepts learned at the RTL level with the physical reality of semiconductor implementation.

The journey can be remembered as:

🧠 Describe the hardware
        ↓
⚙️ Synthesize the logic
        ↓
🕒 Check timing
        ↓
📐 Build the floorplan
        ↓
⚡ Distribute power
        ↓
📍 Place the cells
        ↓
🌳 Build the clock network
        ↓
🛣️ Route the design
        ↓
📊 Extract parasitics
        ↓
🕒 Re-check timing
        ↓
✅ Verify DRC + LVS
        ↓
💾 Generate GDSII

💡 Big Picture

RTL is only the starting description of what the hardware should do.

The remaining stages determine how that logic is:

mapped to a real technology,

positioned physically,

connected using metal,

checked for timing,

verified against manufacturing rules,

and finally represented as a fabrication-ready GDSII layout.

A decision made during RTL development can ultimately affect area, timing, congestion and power much later in the flow. Understanding the complete pipeline makes it easier to see how digital design decisions propagate all the way down to the physical chip.

⭐ Day 6 in One Line

RTL describes the idea → EDA tools implement it → physical verification validates it → GDSII captures the chip layout.
