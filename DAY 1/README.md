# 🚀 Day 1 — Verilog RTL Design & Simulation

> **RTL Design Learning Journey | Day 1**

## 📌 Overview

Day 1 marked the beginning of my **RTL Design journey using Verilog HDL**.

The focus of this session was to understand how a digital circuit is described using Verilog, how its functionality is verified through a testbench and simulation, and how RTL can be converted into a synthesized hardware representation.

As a hands-on exercise, I designed and verified a **2-to-1 Multiplexer** using **Icarus Verilog** and analyzed its simulation waveform using **GTKWave**. I also explored the basics of **RTL synthesis with Yosys**.

---

## 🎯 Objectives

- Understand the fundamentals of **Verilog HDL**
- Learn the purpose of a **Design Module**
- Understand how a **Testbench** verifies a design
- Perform RTL simulation using **Icarus Verilog**
- Analyze simulation waveforms using **GTKWave**
- Implement a **2-to-1 Multiplexer**
- Get introduced to **RTL synthesis using Yosys**

---

## 🛠️ Tools & Technologies

| Tool | Purpose |
|------|---------|
| **Verilog HDL** | Hardware description and RTL design |
| **Icarus Verilog** | Compilation and simulation |
| **GTKWave** | Simulation waveform analysis |
| **Yosys** | RTL synthesis |

---

## 🔄 RTL Design Flow

The basic workflow followed during this experiment was:

```text
        RTL Design
            │
            ▼
       Verilog Code
            │
            ▼
        Testbench
            │
            ▼
     Icarus Verilog
            │
            ▼
       Simulation
            │
            ▼
        VCD File
            │
            ▼
         GTKWave
            │
            ▼
   Waveform Verification
            │
            ▼
          Yosys
            │
            ▼
   Synthesized Hardware
