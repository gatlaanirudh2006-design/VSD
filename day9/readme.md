# ⏱️ Day 9 — SKY130 Module 4: Timing Analysis, CTS & Post-CTS STA

> 🎯 **Focus:** Timing-aware ASIC physical design covering standard-cell timing models,
> setup/hold timing, Clock Tree Synthesis (CTS), clock distribution, placement,
> clock skew, Static Timing Analysis (STA), WNS, TNS, and timing violations.

---

## 🧭 1. Overview

Day 9 focuses on the timing-aware stage of the **SKY130 ASIC physical-design flow**.

The work connects the following concepts:

- 🧩 Standard-cell timing models
- ⏱️ Setup and hold timing
- 🌳 Clock Tree Synthesis
- 🕐 Clock distribution
- 📍 Placement and physical implementation
- ⚖️ Clock skew
- ⚡ Glitch analysis
- 📊 Static Timing Analysis
- 📉 WNS and TNS
- 🚨 Timing violations

The objective is to understand how a synthesized digital design is analyzed and
optimized for timing after physical implementation, and how clock distribution
affects the timing of sequential logic.

### 🔗 Main Timing Flow

```text
📚 Standard-Cell Timing Models
          ↓
📐 Delay Tables
          ↓
⏱️ Setup / Hold Timing
          ↓
🌳 Clock Tree Synthesis (CTS)
          ↓
🕐 Clock Distribution
          ↓
📍 Placement / Physical Implementation
          ↓
⏱️ Post-CTS Timing
          ↓
⚖️ Clock Skew / Glitch Analysis
          ↓
📊 Static Timing Analysis (STA)
          ↓
📉 WNS / TNS & Timing Violations
```

---

# 🧩 2. Day 9 Learning Flow

The complete learning sequence can be represented as:

```text
Standard-Cell Timing Models
          ↓
Delay Tables
          ↓
Setup / Hold Timing
          ↓
Clock Tree Synthesis (CTS)
          ↓
Clock Distribution
          ↓
Placement / Physical Implementation
          ↓
Post-CTS Timing
          ↓
Clock Skew / Glitch Analysis
          ↓
Static Timing Analysis (STA)
          ↓
WNS / TNS and Timing Violations
```

---

# ⏱️ 3. Timing Modeling & Delay Tables

Timing analysis begins with accurate cell timing information.

Standard-cell libraries contain characterized delay and transition information
for different combinations of:

- 🔄 Input slew
- 🧲 Output load capacitance
- 🧱 Cell type
- ↕️ Input/output pin transitions

Delay tables allow the STA engine to estimate the propagation delay of a standard
cell under a particular electrical condition.

---

## 🔍 3.1 Important Timing Concepts

### 🔄 Input Slew

Input slew represents the transition time of the input signal.

### 🧲 Output Load

Output load represents the capacitive load driven by the output of the cell.

### ⏳ Cell Delay

Cell delay represents the propagation delay through the standard cell.

### 🧰 Buffer Delay

Buffer delay is the delay introduced by clock or data buffering.

### 📉 Slew Degradation

Slew degradation describes the change in transition quality as a signal
propagates through logic.

---

## 📊 3.2 Delay Tables

Timing tables are commonly organized around:

```text
Input Slew
    +
Output Load
    ↓
Cell Delay
```

The delay observed on a physical path is not determined only by the logic-cell
delay.

Other contributors include:

- 🔗 Interconnect resistance
- 🧲 Interconnect capacitance
- 🧰 Buffering
- 📏 Physical wire length

Therefore:

```text
Total Path Delay
      =
Cell Delay
+ Interconnect Delay
+ Buffer Delay
+ Other Physical Effects
```

---

# 🎛️ 4. Setup & Hold Timing Analysis

Sequential timing analysis verifies whether data reaches a flip-flop within
the required timing window relative to the clock edge.

A basic sequential timing path can be represented as:

```text
Launch FF ───► Combinational Logic ───► Capture FF
     │                                      │
 Launch Clock                         Capture Clock
```

The two primary checks are:

```text
🟢 Setup Timing
🔴 Hold Timing
```

---

# 🟢 5. Setup Timing

Setup analysis checks whether data arrives sufficiently **before the active
clock edge**.

Conceptually:

```text
Data ───────────────────► | Capture Edge
                          ↑
                    Setup Requirement
```

The data must arrive early enough for the capture flip-flop to reliably sample
the required value.

### ⚠️ Setup Violation

If data arrives too late:

```text
Data Arrival
     ↓
After Required Time
     ↓
❌ Setup Violation
```

---

## 📐 5.1 Setup Timing Concept

The setup requirement can be visualized as:

```text
             Setup Window
        <──────────────────>

Data ────────────────────────
                         │
                         ▼
                   Capture Edge
```

The data must remain stable for the required interval before the clock edge.

---

## 🕐 5.2 Setup Analysis with Ideal Clock

With an ideal clock, the clock arrival relationship is treated as idealized,
without physical clock-network effects.

```text
Launch Clock ───────────────► Launch FF
                                  │
                                  ▼
                         Combinational Logic
                                  │
                                  ▼
Capture Clock ─────────────────► Capture FF
```

This provides an idealized timing reference.

---

## 🌐 5.3 Setup Analysis with Real Clock

After physical clock implementation, the clock travels through an actual network.

```text
Clock Source
     │
     ▼
🌳 Clock Network
     │
     ├── Buffer Delay
     ├── Wire Delay
     ├── RC Effects
     └── Different Path Lengths
     │
     ▼
Sequential Elements
```

Real-clock timing therefore includes physical clock arrival behavior.

---

# 🔴 6. Hold Timing

Hold analysis checks whether data remains stable for the required interval
**after the active clock edge**.

Conceptually:

```text
Capture Edge |────────────────────►
             ↑
        Hold Requirement
```

A new data value arriving too early can cause a **hold violation**.

### ⚠️ Hold Violation

```text
New Data
   ↓
Arrives Too Early
   ↓
❌ Hold Violation
```

---

## 📐 6.1 Hold Timing Concept

```text
              Hold Window
          <────────────────>

Capture Edge
     │
     └────────────────────────
```

The data must remain stable for the required hold interval after the clock edge.

---

## 🕐 6.2 Hold Analysis with Ideal Clock

The ideal-clock assumption does not include physical clock-network arrival
differences.

The timing relationship is evaluated using an idealized clock.

---

## 🌐 6.3 Hold Analysis with Real Clock

Real-clock hold analysis includes the actual clock arrival times and physical
clock-network effects.

```text
Clock Source
     ↓
Clock Distribution
     ↓
Buffers + Interconnect
     ↓
Sequential Elements
```

These physical effects can influence the hold timing relationship.

---

# ⚖️ 7. Ideal Clock vs Real Clock

An ideal clock assumes an idealized arrival relationship without physical
clock-network effects.

After CTS, the clock is distributed through an actual network containing:

- 🧰 Clock buffers
- 🔗 Interconnect
- 🧮 Wire resistance
- 🧲 Wire capacitance
- 📏 Different path lengths

Therefore, real-clock analysis includes:

- ⏱️ Clock insertion delay
- ⚖️ Clock skew
- 📉 Clock transition effects

---

# 🌳 8. Clock Tree Synthesis (CTS)

Clock Tree Synthesis creates a physical clock-distribution network from the clock
source to the sequential elements in the design.

### 🎯 Primary CTS Objectives

- 📍 Deliver the clock to all required sequential elements
- ⏱️ Control clock latency
- ⚖️ Reduce clock skew
- 📈 Maintain acceptable transition characteristics
- 🏗️ Build a physically realizable clock network

The clock network must distribute the clock reliably across the design.

---

# 🌲 9. H-Tree Clock Distribution

An H-tree is a symmetric clock-distribution structure intended to provide
similar path lengths to different branches.

### 🔗 Basic H-Tree Concept

```text
                 Clock Source
                      │
                      ▼
                ──────┬──────
                     / \
                    /   \
                   /     \
                  /       \
                 ─         ─
```

The symmetric structure helps create similar physical paths for different
branches of the clock network.

---

# 🔌 10. Clock Buffers

Clock buffers are inserted to drive the capacitive load of the clock network
and maintain acceptable signal-transition characteristics.

A simplified clock-buffer path is:

```text
Clock Source
     ↓
Clock Buffer
     ↓
Interconnect
     ↓
Sequential Elements
```

Buffers influence:

- ⏱️ Clock delay
- 🔋 Drive capability
- 📈 Signal transition quality
- 🧲 Capacitive loading behavior

---

# 🛡️ 11. Clock-Net Shielding

Clock nets are sensitive to coupling and noise.

Shielding can be used to reduce unwanted capacitive coupling from neighboring
signal wires.

### 🛡️ Shielding Concept

```text
Signal Wire
     │
   Shield
     │
Clock Net
```

The purpose of shielding is to reduce unwanted interference that may affect
clock integrity.

---

# 🧭 12. CTS Terminal / Clock Network

The synthesized network connects the clock source to the required sequential
elements through the physical clock-distribution structure.

```text
                 Clock Source
                      │
                ┌─────┴─────┐
                ▼           ▼
             Buffer       Buffer
                │           │
                ▼           ▼
             Clock         Clock
             Branch        Branch
                │           │
                ▼           ▼
              FFs           FFs
```

The final clock network determines the actual clock arrival time at different
sequential elements.

---

# 📍 13. Physical Implementation & Placement

Timing is strongly affected by physical implementation because interconnect
delay depends on the actual geometry of the design.

### 🧱 Important Physical Factors

- 🗺️ Floorplan
- 📌 Placement
- 📦 Cell locations
- 🛣️ Routing resources
- 📏 Interconnect length
- ⚡ Parasitic effects

---

## 🗺️ 13.1 Floorplan

The floorplan defines the physical organization of the design area.

It establishes:

- Chip/core boundaries
- Available placement area
- Routing regions
- Relative physical organization

---

## 📐 13.2 Layout Grid

The layout grid provides the physical coordinate structure used during
placement and routing.

```text
Grid
 ├── X Coordinates
 ├── Y Coordinates
 └── Placement Locations
```

---

## 📌 13.3 Placement

Placement determines the physical locations of standard cells within the
floorplan.

Good physical placement affects:

- 📏 Wire length
- 🔗 Interconnect delay
- 🧲 Parasitic capacitance
- ⏱️ Timing behavior
- 🛣️ Routing feasibility

---

## 🔍 13.4 Expanded Placement View

An expanded placement view provides greater visibility into the physical
arrangement of cells.

This is useful for inspecting:

- Cell locations
- Relative spacing
- Clock/data connectivity
- Physical organization

---

## 🖥️ 13.5 Placement Terminal View

The placement terminal view provides additional physical and connectivity
information after placement.

---

# ⏲️ 14. Post-CTS Timing Effects

After CTS, timing analysis becomes more realistic because the clock network
is physically implemented.

### ⚠️ Important Post-CTS Effects

- ⏱️ Clock insertion delay
- ⚖️ Clock skew
- 🎯 Clock uncertainty
- 🧰 Clock-buffer delay
- 🔗 Interconnect RC delay
- 📡 Crosstalk / coupling effects
- 📉 Clock-waveform degradation

The difference between ideal-clock and real-clock timing becomes important
during this stage.

---

# ⚖️ 15. Clock Skew

Clock skew is the difference in clock arrival time between two relevant
sequential elements.

For two clock paths:

```text
Skew = |Δ1 - Δ2|
```

The arrival times are influenced by:

- 🧰 Buffer delays
- 🔗 Interconnect delays
- 📏 Path lengths
- 🧲 Parasitic capacitance
- 🧮 Wire resistance

### 🔄 Clock Arrival Example

```text
Clock Source
    │
    ├────────► FF1
    │           ↑
    │        Arrival Δ1
    │
    └────────► FF2
                ↑
             Arrival Δ2

Skew = |Δ1 - Δ2|
```

---

# ⚡ 16. Glitch Analysis

Clock and signal integrity must also be considered during physical
implementation.

Unwanted transitions or glitches can affect timing and functional behavior
depending on where they occur.

Potential contributors include:

- 📡 Coupling
- 🔗 Interconnect effects
- ⏱️ Clock timing differences
- ⚡ Signal transitions

The purpose of glitch analysis is to understand whether unwanted transitions
can influence the implemented design.

---

# 📊 17. Static Timing Analysis (STA)

Static Timing Analysis verifies timing behavior without requiring exhaustive
functional simulation of every possible input sequence.

STA analyzes timing paths and determines whether the design satisfies its
timing constraints.

### 🔑 Important STA Quantities

```text
🕐 Data Arrival Time
⏳ Data Required Time
📐 Slack
📉 WNS
🟠 TNS
```

---

## 🕐 17.1 Data Arrival Time

The **Data Arrival Time** is the time at which data reaches the capture point.

The data path can be represented as:

```text
Launch FF
   ↓
Combinational Logic
   ↓
Interconnect
   ↓
Capture FF
```

The total arrival time depends on the delays accumulated through the path.

---

## ⏳ 17.2 Data Required Time

The **Data Required Time** is the latest time by which data must arrive to
satisfy the timing constraint.

Conceptually:

```text
Required Time
      │
      ▼
─────────────── Capture Requirement
      ▲
      │
Data Arrival
```

---

## 📐 17.3 Slack

Slack represents the timing margin available on a path.

For setup analysis:

```text
Slack = Data Required Time - Data Arrival Time
```

### ✅ Positive Slack

```text
Required Time > Arrival Time
        ↓
✅ Timing Margin Available
```

### 🚨 Negative Slack

```text
Arrival Time > Required Time
        ↓
❌ Timing Requirement Not Met
```

A negative setup slack indicates that the analyzed path does not meet the
corresponding setup requirement.

---

# 🖥️ 18. STA Output

STA reports contain timing-path information such as:

- 🧱 Cell delays
- 🔗 Net delays
- 🕐 Clock information
- 🕐 Data arrival time
- ⏳ Data required time
- 📐 Slack

A typical timing path can be represented as:

```text
Startpoint
    ↓
Logic Cell
    ↓
Net
    ↓
Logic Cell
    ↓
Net
    ↓
Endpoint
    ↓
Timing Check
    ↓
Slack
```

---

# 📉 19. WNS & TNS

Two important timing-summary metrics are:

```text
🔴 WNS — Worst Negative Slack
🟠 TNS — Total Negative Slack
```

---

## 🔴 19.1 Worst Negative Slack (WNS)

WNS represents the most negative slack among the analyzed violating paths.

```text
WNS = minimum slack
```

For a timing-clean group of paths:

```text
Worst Slack ≥ 0
```

WNS therefore identifies the worst individual timing margin.

---

## 🟠 19.2 Total Negative Slack (TNS)

TNS represents the accumulated negative slack across violating paths.

```text
TNS = Sum of Negative Slacks
```

It provides an indication of the overall magnitude of timing violations.

---

## 🧠 19.3 WNS vs TNS

| Metric | Meaning |
|---|---|
| 🔴 **WNS** | Worst individual timing margin |
| 🟠 **TNS** | Aggregate magnitude of timing violations |

### Example

```text
Path 1 → Slack = -0.20 ns
Path 2 → Slack = -0.10 ns
Path 3 → Slack = +0.05 ns

WNS = -0.20 ns

TNS = -0.20 + (-0.10)
    = -0.30 ns
```

---

# 🔗 20. Key Engineering Relationships

The main relationships studied during Day 9 can be summarized as:

```text
Cell Characterization
        │
        ├── Input Slew
        ├── Output Load
        └── Cell Delay
               │
               ▼
        Timing Analysis
               │
        ┌──────┴──────┐
        ▼             ▼
      Setup          Hold
        │             │
        └──────┬──────┘
               ▼
              CTS
               │
        ┌──────┼──────┐
        ▼      ▼      ▼
     Buffers  Skew  Clock RC
               │
               ▼
          Post-CTS STA
               │
         ┌─────┴─────┐
         ▼           ▼
        WNS         TNS
```

This shows how cell-level timing information eventually contributes to
chip-level timing analysis.

---

# 🏗️ 21. Practical VLSI Significance

Day 9 connects timing theory with actual ASIC implementation.

A design may be logically correct at RTL and still fail timing after synthesis
or physical implementation because:

### ⏳ Logic Delay

Logic paths have finite propagation delay.

### 🧱 Cell Characteristics

Different standard cells have different delay characteristics.

### 🔗 Interconnect Effects

Interconnect introduces resistance and capacitance.

### 🕐 Clock Insertion Delay

Physical clock paths introduce additional delay.

### ⚖️ Clock Skew

Different clock paths can produce different arrival times.

### ✅ Setup & Hold Requirements

Both setup and hold constraints must be satisfied.

---

## 🔄 21.1 Timing Closure Loop

Timing closure is an iterative process:

```text
RTL
 ↓
Synthesis
 ↓
Cell Selection / Buffering
 ↓
Placement
 ↓
CTS
 ↓
Routing
 ↓
Parasitic Extraction
 ↓
STA
 ↓
Timing Fixes
 ↺
```

The design may need to move through this loop multiple times before the timing
constraints are satisfied.

---

# 🎯 22. Day 9 Key Learnings

By completing this module, the following concepts were studied.

---

## ⏱️ Timing Analysis

- Standard-cell timing characterization
- Input slew and output load
- Delay tables
- Cell delay
- Buffer delay
- Slew degradation
- Setup timing
- Hold timing
- Ideal-clock timing analysis
- Real-clock timing analysis

---

## 🌳 Clock Network

- Clock Tree Synthesis
- H-tree clock distribution
- Clock buffering
- Clock-net shielding
- Clock insertion delay
- Clock skew
- Glitch analysis

---

## 📍 Physical Implementation

- Floorplan
- Placement
- Layout grid
- Cell locations
- Routing resources
- Interconnect length
- Parasitic effects

---

## 📊 Static Timing Analysis

- Static Timing Analysis
- Data arrival time
- Data required time
- Slack
- WNS
- TNS
- Timing violations
- Timing closure

---

# ✅ 23. Day 9 Completion Checklist

### 📚 Timing

- ☑️ Studied timing-model concepts
- ☑️ Studied delay tables and buffering
- ☑️ Studied setup timing
- ☑️ Studied hold timing
- ☑️ Compared ideal and real clock behavior

### 🌳 Clock Tree

- ☑️ Studied Clock Tree Synthesis
- ☑️ Studied H-tree clock distribution
- ☑️ Studied clock buffering
- ☑️ Studied clock-net shielding

### 📍 Physical Design

- ☑️ Reviewed physical placement
- ☑️ Studied clock skew
- ☑️ Studied glitch behavior

### 📊 STA

- ☑️ Reviewed STA reports
- ☑️ Studied data arrival time
- ☑️ Studied data required time
- ☑️ Studied slack
- ☑️ Studied WNS and TNS

### 🔗 Overall Understanding

- ☑️ Connected timing analysis with physical implementation
- ☑️ Understood the relationship between CTS and STA
- ☑️ Connected physical effects with timing closure

---

# 🏁 24. Day 9 Summary

Day 9 establishes the connection between:

```text
⏱️ Timing Models
       ↓
🌳 Clock Distribution
       ↓
📍 Physical Implementation
       ↓
📊 Static Timing Analysis
       ↓
📉 Timing Closure
```

The central concept is that timing is affected not only by logical-cell delay,
but also by physical implementation.

The complete relationship can be viewed as:

```text
RTL
 ↓
Synthesis
 ↓
Standard Cells
 ↓
Placement
 ↓
CTS
 ↓
Routing
 ↓
Parasitics
 ↓
STA
 ↓
WNS / TNS
 ↓
Timing Closure
```

---

## 💡 Final Takeaway

> **Physical implementation changes timing, and Static Timing Analysis is used to
> measure whether the implemented design satisfies its timing constraints.**

Day 9 therefore provides an important foundation for understanding **timing
closure in a complete ASIC design flow**.
