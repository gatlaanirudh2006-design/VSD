# 🚀 Day 1 — Verilog RTL Design & Simulation

## 📌 Overview

Day 1 focused on the fundamentals of **Verilog RTL Design, Testbench, Simulation, Waveform Analysis, and RTL Synthesis**.

A **2-to-1 Multiplexer** was designed, simulated using **Icarus Verilog**, verified using **GTKWave**, and synthesized using **Yosys**.

---

## 🛠️ Tools Used

- **Verilog HDL** – RTL Design
- **Icarus Verilog** – Simulation
- **GTKWave** – Waveform Analysis
- **Yosys** – RTL Synthesis

---

## 1. Verilog RTL Design

The first task was to understand the structure of a Verilog RTL module and implement a simple **2-to-1 Multiplexer**.

![2-to-1 Multiplexer Verilog Code](mux_code.png)

### Multiplexer Operation

| `sel` | Output |
|:---:|:---:|
| `0` | `i0` |
| `1` | `i1` |

---

## 2. Simulation Flow

The Verilog design and testbench were compiled and simulated using **Icarus Verilog**. The simulation generated a **VCD file**, which was then viewed using **GTKWave**.

![Icarus Verilog Simulation Flow](simulation_flow.png)

### Commands

```bash
sudo apt update
sudo apt install iverilog
sudo apt install gtkwave
sudo apt install yosys
```

### Compile

```bash
iverilog -o mux_sim good_mux.v tb_good_mux.v
```

### Run

```bash
vvp mux_sim
```

### View Waveform

```bash
gtkwave tb_good_mux.vcd
```

---

## 3. Testbench

A testbench was used to provide different input combinations to the multiplexer and verify the output.

![Testbench Structure](testbench.png)

The basic verification flow is:

```text
Stimulus → Design → Output Observation
```

---

## 4. RTL Design Representation

The design receives the primary inputs `i0`, `i1`, and `sel`, and produces the output `y`.

![RTL Design Representation](design.png)

---

## 5. Yosys Synthesis

After simulation, the RTL was synthesized using **Yosys**.

### Synthesis Command

```bash
yosys -p "read_verilog good_mux.v; hierarchy -top good_mux; proc; opt; techmap; opt; show"
```

This converts the Verilog RTL into a synthesized hardware representation.

---

## 📚 Key Learnings

- Basics of **Verilog RTL Design**
- Difference between **Design and Testbench**
- Verilog simulation using **Icarus Verilog**
- Waveform analysis using **GTKWave**
- Implementation of a **2-to-1 Multiplexer**
- Introduction to **RTL Synthesis using Yosys**

---

## ✅ Day 1 Outcome

Successfully designed, simulated, verified, and synthesized a **2-to-1 Multiplexer**, gaining practical exposure to the basic RTL design flow.

### RTL → Simulation → Verification → Synthesis 🚀ux.v
```

---

### ✅ Day 1 Complete

**Verilog RTL Design → Simulation → Verification → Synthesis**
