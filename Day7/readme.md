# 🔷 Day 7 — OpenLane Physical Design

## 📐 Floorplanning, Placement & Power Distribution

> 🧠 **Focus:** Moving from synthesized logic to its physical organization inside the chip using **OpenLane + SKY130 + PicoRV32**.

---

## 🎯 Objective

Day 7 takes the concepts introduced in the RTL-to-GDSII flow and moves into the **physical design stage**.

The practical work uses **OpenLane** with the **SKY130 PDK** and the **PicoRV32** processor design. The main stages covered are:

```text
📝 RTL
   ↓
⚙️ Synthesis
   ↓
📐 Floorplanning
   ↓
📍 Placement
   ↓
⚡ Power Distribution
```

The session also focuses on understanding what the **die** and **core** physically represent, how floorplan parameters affect the design, why a **Power Distribution Network (PDN)** is required, and how **decoupling capacitors** help maintain supply stability.

---

# 📚 Contents

1. 🔄 Position of Day 7 in the ASIC Flow
2. 🐳 Starting OpenLane
3. ⚙️ Performing Synthesis
4. ⬜ Understanding Core and Die
5. 📐 Floorplanning
6. 📍 Placement
7. 👀 Inspecting Layout Using Magic
8. ⚡ Power Distribution Network
9. 🔋 Decoupling Capacitors
10. 💻 Command Reference
11. 🏁 Conclusion

---

# 1️⃣ 🔄 Where Day 7 Fits in the RTL-to-GDSII Flow

The overall ASIC implementation process can be represented as:

```text
        📝 RTL
          ↓
      ⚙️ Synthesis
          ↓
      📐 Floorplan
          ↓
      📍 Placement
          ↓
    ⚡ Power Distribution
          ↓
      🌳 CTS
          ↓
      🛣️ Routing
          ↓
      ✅ Physical Verification
          ↓
        💾 GDSII
```

### 📌 Today's focus

Day 7 concentrates mainly on:

```text
Synthesis
    ↓
Floorplanning
    ↓
Placement
    ↓
Power Distribution Concepts
```

Clock Tree Synthesis, routing and final physical verification are handled in later stages.

---

# 2️⃣ 🐳 Launching OpenLane

OpenLane is executed inside a **Docker container**.

The working directory and the SKY130 PDK are mounted into the container so that OpenLane can access the required files.

### 📂 Move to the OpenLane directory

```bash
cd ~/Desktop/work/tools/openlane_working_dir/openlane
```

### 🔎 Check the PDK location

```bash
echo $PDK_ROOT
```

### 🚫 Remove the Docker alias

```bash
unalias docker
```

### 🐳 Start the OpenLane container

```bash
docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT \
  -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) \
  efabless/openlane:v0.21
```

### 💡 What is `PDK_ROOT`?

`PDK_ROOT` points to the location where the SKY130 PDK is installed.

The Docker command mounts:

```text
📁 OpenLane working directory
          +
📦 SKY130 PDK
          ↓
🐳 Docker Container
```

This allows the tools running inside Docker to access both the design files and technology information.

---

## 🖥️ Running OpenLane Interactively

Instead of executing the entire flow at once, OpenLane can be started in **interactive mode**.

This is especially useful when learning because each stage can be executed separately and its intermediate output can be inspected.

### ▶️ Start interactive mode

```bash
cd /openLANE_flow
./flow.tcl -interactive
```

### 📦 Prepare the design

```tcl
prep -design <design_name>
```

The `prep` command prepares the design by loading:

* 📝 RTL files
* ⚙️ Design configuration
* 📦 PDK information
* 🧱 Standard-cell libraries
* ⏱️ Timing libraries

---

# 3️⃣ ⚙️ Running Synthesis

Once the design is prepared, synthesis can be started with:

```tcl
run_synthesis
```

### 🔄 What happens here?

The RTL is converted into a **gate-level netlist** and mapped to cells available in the SKY130 technology.

```text
📝 RTL
   ↓
⚙️ Yosys + ABC
   ↓
🔲 Gate-Level Netlist
   ↓
🧱 SKY130 Standard Cells
```

This is the same synthesis concept studied earlier, but now synthesis is being executed as part of the OpenLane physical-design flow.

---

## 📊 Flip-Flop Analysis

For the PicoRV32 synthesis run:

| 📌 Parameter         |     🔢 Value |
| -------------------- | -----------: |
| Flip-Flops           |     **1613** |
| Total Cells          |    **14876** |
| Flip-Flop Percentage | **≈ 10.84%** |

### 🧮 Calculation

```text
Flip-Flop Percentage

= (Number of Flip-Flops / Total Cells) × 100

= (1613 / 14876) × 100

≈ 10.84%
```

### 💡 What does this tell us?

The percentage provides an indication of how much of the synthesized design contains **state-holding sequential elements** compared with the complete cell count.

The remaining cells are largely associated with combinational logic.

This information becomes useful when considering later aspects such as:

* 🕒 Timing
* ⚡ Power
* 🧠 Sequential behavior

---

# 4️⃣ ⬜ Core vs Die

Understanding the difference between **die** and **core** is essential before studying floorplanning.

## 🟦 Die

The **die** represents the complete physical silicon area.

It can contain:

* Core region
* I/O-related regions
* Power structures
* Other physical structures

## 🟩 Core

The **core** is the inner region where the standard-cell logic is placed.

### 🗺️ Simplified Structure

```text
+------------------------------------------+
|                   DIE                    |
|                                          |
|     +--------------------------------+   |
|     |              CORE              |   |
|     |                                |   |
|     |      Standard Cells             |   |
|     |      Routing                    |   |
|     |      Power Distribution         |   |
|     |                                |   |
|     +--------------------------------+   |
|                                          |
+------------------------------------------+
```

### 📌 Why isn't the core equal to the die?

Some space must exist around the core for structures such as:

* 🔌 I/O-related elements
* ⚡ Power distribution
* 🛣️ Physical routing
* 🧱 Other implementation requirements

Therefore:

```text
Die Area > Core Area
```

in a typical arrangement.

---

# 5️⃣ 📐 Floorplanning

Floorplanning establishes the initial physical organization of the design.

The OpenLane command used is:

```tcl
run_floorplan
```

### 🧩 Floorplanning determines factors such as:

* 📏 Die dimensions
* ⬜ Core dimensions
* 📊 Cell utilization
* 📐 Aspect ratio
* ↔️ Margins
* 🛣️ Space available for routing
* ⚡ Space for power structures

A good floorplan is important because decisions made here influence later stages.

### ⚠️ Poor floorplanning can result in:

```text
Bad Floorplan
    ↓
High Congestion
    ↓
Longer Interconnects
    ↓
Timing Problems
    ↓
Routing Difficulties
```

---

## 📊 Core Utilization

The design uses:

```text
FP_CORE_UTIL = 35
```

This means the target utilization of the core area by standard cells is approximately:

```text
35% → Standard-cell area
65% → Remaining whitespace
```

### 🧠 Why leave whitespace?

The unused area provides room for:

* 🛣️ Routing
* ⚡ Power structures
* 🌳 Clock buffers
* 🔋 Decoupling capacitors
* 📍 Placement flexibility

If utilization becomes too high, the available routing space decreases and congestion can become a serious problem.

---

## 📐 Aspect Ratio

The selected aspect ratio is:

```text
Aspect Ratio = 1
```

This means the width and height are approximately equal.

Therefore, the resulting core shape is approximately:

```text
┌──────────────┐
│              │
│    CORE      │
│              │
└──────────────┘
```

or approximately square.

---

# 📏 Die Area Calculation

The generated DEF contains:

```text
UNITS DISTANCE MICRONS 1000 ;
DIEAREA ( 0 0 ) ( 660805 671405 )
```

The database uses:

```text
1000 database units = 1 µm
```

Therefore:

### ↔️ Width

```text
Width = 660805 / 1000

      = 660.805 µm
```

### ↕️ Height

```text
Height = 671405 / 1000

       = 671.405 µm
```

### 📐 Area

```text
Area = Width × Height

     = 660.805 × 671.405

     ≈ 443,667.78 µm²
```

Converting to mm²:

```text
≈ 0.44367 mm²
```

### 📌 Final Die Dimensions

```text
Width  ≈ 660.805 µm
Height ≈ 671.405 µm
Area   ≈ 443,667.78 µm²
       ≈ 0.44367 mm²
```

---

# 6️⃣ 📍 Placement

After floorplanning, the standard cells need actual physical locations.

The command is:

```tcl
run_placement
```

### 🔄 What placement does

Before placement, the synthesized netlist mainly tells us:

```text
Which cell connects to which cell
```

After placement, each cell receives an actual physical position.

```text
🔲 Synthesized Netlist
          ↓
     🧱 Standard Cells
          ↓
      📍 X / Y Position
```

### 🎯 Placement tries to balance:

* 📏 Wire length
* 🕒 Timing
* 🚦 Congestion
* 📊 Cell density
* ⚡ Power

A poor placement can cause:

```text
Poor Placement
      ↓
Long Wires
      ↓
More Delay
      ↓
Higher Congestion
      ↓
Possible Timing Violations
```

Therefore placement has a major influence on subsequent routing and timing.

---

# 7️⃣ 👀 Viewing the Layout in Magic

Once floorplanning and placement have generated physical data, the design can be viewed using **Magic**.

### 🖥️ Command

```bash
magic -T /home/vsduser/Desktop/work/tools/openlane_working_dir/pdks/sky130A/libs.tech/magic/sky130A.tech \
  lef read ../../tmp/merged.lef \
  lef def read picorv32a.floorplan.def &
```

---

## 🔍 Understanding the Command

### `-T sky130A.tech`

```text
-T <technology-file>
```

Loads the SKY130 technology information so Magic knows how to interpret the different layout layers.

---

### `lef read ../../tmp/merged.lef`

Loads the merged **LEF** information.

LEF contains physical abstracts such as:

* 📏 Cell dimensions
* 📍 Pin information
* 🛣️ Metal-layer information
* 🔌 Routing abstracts

---

### `lef def read picorv32a.floorplan.def`

Loads the **DEF** containing the physical implementation information, including:

* 📐 Die information
* 📍 Cell coordinates
* 🔗 Nets
* 🧱 Placement information

---

### `&`

The `&` runs the command in the background, allowing the terminal to remain available.

### 🔄 Overall Relationship

```text
Technology File
      +
    LEF
      +
    DEF
      ↓
   🪄 Magic
      ↓
👀 Physical Layout
```

---

# 8️⃣ ⚡ Power Distribution Network — PDN

A chip cannot operate simply by placing logic cells. Every standard cell needs reliable connections to:

```text
VDD → Supply
GND/VSS → Ground
```

The power network must distribute current across the entire chip.

---

## ⚡ Why does IR Drop happen?

Power wires have resistance.

When current flows through resistance, a voltage drop occurs:

```text
V = I × R
```

Therefore:

```text
IR Drop = Current × Resistance
```

### ⚠️ Problem

If the power network is poorly designed:

```text
Power Source
     ↓
Long / Resistive Path
     ↓
Voltage Drop
     ↓
Lower Supply at Cell
     ↓
Unreliable Operation
```

Cells farther from the power source can experience greater voltage drop.

---

# 🕸️ Power Distribution Network

A **PDN** provides multiple paths for delivering power across the chip.

### 🔄 Typical hierarchy

```text
⚡ Power Source
       ↓
   Power Ring
       ↓
   Power Mesh
       ↓
   Power Straps
       ↓
 Standard-Cell Rails
       ↓
 Individual Cells
```

This reduces effective resistance and helps distribute current more uniformly.

---

# 📊 Power Mesh Parameters

The design uses the following values:

| ⚙️ Parameter       |   🔢 Value |
| ------------------ | ---------: |
| Core Ring Offset   |      **6** |
| Core Ring Spacing  |    **1.7** |
| Core Ring Width    |    **1.6** |
| Lower Metal Layer  |   **met4** |
| Upper Metal Layer  |   **met5** |
| Rail Layer         |   **met1** |
| Rail Width         |   **0.48** |
| Pitch              | **153.18** |
| Horizontal Spacing |    **1.7** |
| Vertical Spacing   |    **1.7** |
| Vertical Width     |    **1.6** |

### 🧠 Layer usage

Higher metal layers such as:

```text
met4
met5
```

are useful for distributing power over longer distances.

The lower layer:

```text
met1
```

provides the finer connection into the standard-cell rows.

---

# 9️⃣ 🔋 Decoupling Capacitors

The PDN handles power distribution, but another problem occurs when many cells switch at nearly the same time.

### ⚡ Sudden switching event

```text
Many cells switch
       ↓
Current demand suddenly increases
       ↓
Temporary supply disturbance
       ↓
Local voltage dip
```

The power network cannot always respond instantly to a rapid transient demand.

---

## 🔋 What does a Decap do?

A **decoupling capacitor**, or **decap**, acts like a small local charge reservoir.

When a sudden current demand occurs:

```text
Normal condition
      ↓
Decap stores charge
      ↓
Sudden switching
      ↓
Local voltage drops
      ↓
Decap releases charge
      ↓
Supply disturbance is reduced
```

### 🧩 Power Mesh vs Decap

These two solve different problems:

| ⚡ Power Mesh                       | 🔋 Decoupling Capacitor                 |
| ---------------------------------- | --------------------------------------- |
| Handles overall power distribution | Handles local transient demand          |
| Provides continuous supply paths   | Temporarily supplies stored charge      |
| Covers the chip-scale network      | Helps nearby cells                      |
| Reduces distribution resistance    | Smooths short-term voltage fluctuations |

### 💡 Simple comparison

```text
⚡ PDN
= Highway for power distribution

🔋 Decap
= Local emergency energy reservoir
```

Both are important for maintaining a stable power supply.

---

# 🔟 💻 Command Reference

| 🧩 Operation             | 💻 Command                                                                                                                                      |
| ------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Enter OpenLane directory | `cd ~/Desktop/work/tools/openlane_working_dir/openlane`                                                                                         |
| Display PDK location     | `echo $PDK_ROOT`                                                                                                                                |
| Remove Docker alias      | `unalias docker`                                                                                                                                |
| Start OpenLane container | `docker run -it -v $(pwd):/openLANE_flow -v $PDK_ROOT:$PDK_ROOT -e PDK_ROOT=$PDK_ROOT -u $(id -u $USER):$(id -g $USER) efabless/openlane:v0.21` |
| Enter flow directory     | `cd /openLANE_flow`                                                                                                                             |
| Launch interactive mode  | `./flow.tcl -interactive`                                                                                                                       |
| Prepare design           | `prep -design <design_name>`                                                                                                                    |
| Run synthesis            | `run_synthesis`                                                                                                                                 |
| Run floorplan            | `run_floorplan`                                                                                                                                 |
| Run placement            | `run_placement`                                                                                                                                 |
| Open layout in Magic     | `magic -T <tech_file> lef read <merged.lef> lef def read <design>.floorplan.def &`                                                              |

---

# 🏁 1️⃣1️⃣ Conclusion

Day 7 takes the RTL-to-GDSII concept from the previous stage and makes the **physical implementation process tangible**.

The main practical sequence is:

```text
📝 RTL
  ↓
⚙️ Synthesis
  ↓
📐 Floorplanning
  ↓
📍 Placement
  ↓
⚡ Power Distribution
```

Several important physical-design concepts were explored:

### 📌 Core & Die

```text
DIE
└── CORE
    └── Standard-cell region
```

The die represents the overall silicon area, while the core contains the main standard-cell placement region.

### 📌 Floorplan

The selected design used:

```text
FP_CORE_UTIL = 35%
Aspect Ratio = 1
```

The generated die dimensions were approximately:

```text
660.805 µm × 671.405 µm
```

with an area of approximately:

```text
443,667.78 µm²
≈ 0.44367 mm²
```

### 📌 Synthesis Result

The PicoRV32 design contained:

```text
1613 Flip-Flops
14876 Total Cells
≈ 10.84% Flip-Flops
```

### 📌 PDN

The power distribution network provides reliable paths from the power source to the individual cells while reducing the impact of resistance and IR drop.

### 📌 Decaps

Decoupling capacitors provide local temporary charge during sudden switching activity, helping reduce transient supply disturbances.

---

# 🌟 Day 7 — Quick Revision

```text
                 📝 RTL
                   │
                   ▼
              ⚙️ Synthesis
                   │
                   ▼
             📐 Floorplan
                   │
        ┌──────────┴──────────┐
        │                     │
   ⬜ Die / Core          📊 Utilization
        │                     │
        └──────────┬──────────┘
                   ▼
               📍 Placement
                   │
                   ▼
              ⚡ Power Grid
                   │
             ┌─────┴─────┐
             │           │
          ⚡ PDN       🔋 Decap
             │           │
             └─────┬─────┘
                   ▼
             🌳 CTS / Routing
                   ▼
               💾 GDSII
```

> 🚀 **Key takeaway:** Day 7 is where the synthesized logic starts acquiring a real physical shape. Floorplanning determines *where the design fits*, placement determines *where the cells go*, and the PDN ensures *those cells receive reliable power*. These decisions directly influence routing, timing, congestion and ultimately the quality of the final chip.

