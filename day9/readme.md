Day 9 — SKY130 Module 4: Timing Analysis, CTS & Post-CTS STA

🎯 Focus

Timing-aware ASIC physical design: standard-cell timing models, setup/hold,
clock-tree synthesis, clock distribution, placement, skew, STA, WNS and TNS.

🧭 1. Overview

Day 9 focuses on the timing-aware stage of the SKY130 ASIC physical-design flow.
The work connects standard-cell timing models with sequential timing, physical
clock distribution and post-CTS static timing analysis.

🔗 Core idea

📚 Timing Models
      ↓
📐 Setup / Hold
      ↓
🌳 Clock Tree Synthesis
      ↓
📍 Physical Implementation
      ↓
⏱️ Post-CTS Timing
      ↓
📊 STA
      ↓
⚠️ WNS / TNS / Violations

The objective is to understand how timing is analyzed and improved after physical
implementation, and how the clock network influences sequential timing.

🧩 2. Day 9 Learning Flow

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
WNS / TNS & Timing Violations

⏱️ 3. Timing Modeling & Delay Tables

Timing analysis begins with characterized standard-cell timing information.

📌 Timing depends on

Parameter

Meaning

🔄 Input slew

Transition time of the input signal

🔋 Output load

Capacitive load driven by the cell

🧱 Cell type

Type of standard cell being analyzed

↕️ Pin transition

Input/output transition condition

Delay tables allow the STA engine to estimate propagation delay for a particular
electrical operating condition.

🔍 Important timing terms

🔄 Input slew — transition time of the incoming signal.

🧲 Output load — capacitance driven by the cell.

⏳ Cell delay — propagation delay through the standard cell.

🧰 Buffer delay — delay introduced by clock/data buffers.

📉 Slew degradation — deterioration of transition quality as a signal propagates.

🧮 Delay Components

💡 Key point: Total path delay depends not only on cell delay, but also on
interconnect resistance, capacitance, buffering and physical wire length.

🎛️ 4. Setup & Hold Timing Analysis

Sequential timing checks whether data reaches a capture flip-flop within the
required timing window relative to the clock edge.

Launch FF ───► Combinational Logic ───► Capture FF
    │                                      │
Launch Clock                          Capture Clock

🟢 4.1 Setup Timing

Setup analysis checks whether data arrives sufficiently before the active
clock edge.

Data ───────────────► | Capture Edge
                      ↑
                Setup requirement

A late-arriving data signal can create a setup violation.

🔴 4.2 Hold Timing

Hold analysis checks whether data remains stable for the required interval
after the active clock edge.

Capture Edge |────────────►
             ↑
        Hold requirement

A new data value arriving too early can cause a hold violation.

⚖️ 4.3 Ideal Clock vs Real Clock

An ideal clock assumes an idealized arrival relationship without physical
clock-network effects.

After CTS, the clock travels through a real network containing:

🧰 Clock buffers

🔗 Interconnect

🧮 Wire resistance

🧲 Wire capacitance

📏 Different path lengths

Therefore, real-clock timing includes clock insertion delay and clock skew.

🌳 5. Clock Tree Synthesis (CTS)

Clock Tree Synthesis creates a physical clock-distribution network from the clock
source to the sequential elements in the design.

🎯 Main CTS objectives

📍 Reach all required sequential elements

⏱️ Control clock latency

⚖️ Reduce clock skew

📈 Maintain acceptable transition characteristics

🏗️ Create a physically realizable clock network

🌲 5.1 H-Tree Clock Distribution

🔌 5.2 Clock Buffers

🛡️ 5.3 Clock-Net Shielding

🧭 5.4 CTS Terminal / Clock Network

📍 6. Physical Implementation & Placement

Timing is strongly affected by physical implementation because interconnect delay
depends on the actual geometry of the design.

🧱 Physical-design factors

🗺️ Floorplan

📌 Placement

📦 Cell locations

🛣️ Routing resources

📏 Interconnect length

⚡ Parasitic effects

🧱 Layout Grid

🔍 Expanded Placement

⏲️ 7. Post-CTS Timing Effects

After CTS, timing becomes more realistic because the clock network is physically
implemented.

⚠️ Important post-CTS effects

⏱️ Clock insertion delay

⚖️ Clock skew

🎯 Clock uncertainty

🧰 Clock-buffer delay

🔗 Interconnect RC delay

📡 Crosstalk / coupling effects

📉 Clock-waveform degradation

⚖️ 7.1 Clock Skew

Clock skew is the difference in clock arrival time between two relevant
sequential elements.

Skew = |Δ1 - Δ2|

The arrival times depend on the physical clock network and its associated delays.

⚡ 7.2 Glitch Analysis

📊 8. Static Timing Analysis (STA)

Static Timing Analysis verifies timing behavior without requiring exhaustive
functional simulation of every possible input sequence.

STA analyzes timing paths and checks whether the design satisfies its timing
constraints.

🔑 Core STA quantities

🕐 Data Arrival Time

The time at which data reaches the capture point.

⏳ Data Required Time

The latest time by which data must arrive to satisfy the timing constraint.

📐 Slack

Slack represents the timing margin.

For setup analysis:

Slack = Data Required Time - Data Arrival Time

🚨 A negative setup slack indicates that the analyzed path does not meet
the corresponding setup requirement.

🖥️ STA Output

STA reports contain timing-path information such as cell delay, net delay,
clock information, data arrival time, data required time, and slack.

📉 9. WNS & TNS

Two important timing-summary metrics are Worst Negative Slack (WNS) and
Total Negative Slack (TNS).

🔴 Worst Negative Slack (WNS)

WNS represents the most negative slack among analyzed violating paths.

WNS = minimum slack

For a timing-clean group, the worst slack is non-negative.

🟠 Total Negative Slack (TNS)

TNS represents the accumulated negative slack across violating paths.

TNS = sum of negative slacks

🧠 Difference at a glance

Metric

What it tells you

🔴 WNS

Worst individual timing margin

🟠 TNS

Aggregate magnitude of timing violations

🔗 10. Key Engineering Relationships

The major Day 9 relationships can be visualized as:

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

🏗️ 11. Practical VLSI Significance

Day 9 connects timing theory with actual ASIC implementation.

A design may be logically correct at RTL and still fail timing after synthesis
or physical implementation because:

⏳ Logic paths have finite propagation delay.

🧱 Standard cells have different delay characteristics.

🔗 Interconnect contributes resistance and capacitance.

🕐 Clock paths have insertion delay.

⚖️ Different clock paths can have different arrival times.

✅ Both setup and hold constraints must be satisfied.

🔄 Timing-closure loop

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

Therefore, timing closure is an iterative process across logical and physical
design stages.

🎯 12. Day 9 Key Learnings

By completing this module, the following concepts were studied:

⏱️ Timing

Standard-cell timing characterization

Input slew and output load

Delay tables

Cell and buffer delay

Setup timing

Hold timing

Ideal-clock timing analysis

Real-clock timing analysis

🌳 Clock Network

Clock Tree Synthesis

H-tree clock distribution

Clock buffering

Clock-net shielding

Clock insertion delay

Clock skew

Glitch analysis

📊 STA

Static Timing Analysis

Data arrival time

Data required time

Slack

WNS

TNS

Timing violations

Timing closure

📍 Physical Design

Placement

Interconnect effects

Physical clock implementation

Post-CTS timing behavior

✅ 13. Day 9 Completion Checklist

☑️ Studied timing-model concepts

☑️ Studied delay tables and buffering

☑️ Studied setup timing

☑️ Studied hold timing

☑️ Compared ideal and real clock behavior

☑️ Studied Clock Tree Synthesis

☑️ Studied H-tree clock distribution

☑️ Studied clock buffering

☑️ Studied clock-net shielding

☑️ Reviewed physical placement

☑️ Studied clock skew

☑️ Studied glitch behavior

☑️ Reviewed STA reports

☑️ Studied WNS and TNS

☑️ Connected timing analysis with physical implementation

🏁 14. Conclusion

Day 9 establishes the connection between timing models, clock distribution,
physical implementation, and STA in the SKY130 ASIC flow.

💡 Central idea: Physical implementation changes timing, and STA measures
whether the implemented design satisfies its timing constraints.

This module provides a foundation for understanding timing closure in a
complete ASIC design flow.
