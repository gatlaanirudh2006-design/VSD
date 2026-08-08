# 🚀 Day 1 — Verilog RTL Design & Simulation

## 📌 Overview

Day 1 focused on the fundamentals of **Verilog RTL Design, Testbench, Simulation, Waveform Analysis, and RTL Synthesis**.

As a practical exercise, a **2-to-1 Multiplexer** was designed and simulated using **Icarus Verilog**, verified using **GTKWave**, and synthesized using **Yosys**.

---

## 🛠️ Tools Used

- **Verilog HDL** – RTL Design
- **Icarus Verilog** – Simulation
- **GTKWave** – Waveform Analysis
- **Yosys** – RTL Synthesis

---

## 1. Verilog RTL Design

A **2-to-1 Multiplexer** was implemented using Verilog.

### Multiplexer Operation

| `sel` | Output |
|:---:|:---:|
| `0` | `i0` |
| `1` | `i1` |

### Verilog Code

```verilog
module good_mux (
    input i0,
    input i1,
    input sel,
    output reg y
);

always @(*)
begin
    if(sel)
        y <= i1;
    else
        y <= i0;
end

endmodule
```
<img width="1212" height="570" alt="image" src="https://github.com/user-attachments/assets/fa4d2b59-c397-46b3-8621-d0510942e820" />

---

## 2. Simulation Flow

The design and testbench were compiled using **Icarus Verilog**.

```text
Design + Testbench
        ↓
 Icarus Verilog
        ↓
   Simulation
        ↓
     VCD File
        ↓
    GTKWave
        ↓
Waveform Verification
```

---

## 3. Testbench

A testbench was created to apply different input combinations and verify the multiplexer output.

```text
Stimulus → Design → Output Observation
```

The testbench generates the required input combinations and checks whether the output follows the selected input.

---

## 4. Simulation Commands
<img width="1402" height="649" alt="image" src="https://github.com/user-attachments/assets/9fe534aa-154a-47cb-962a-bab11a3540cc" />

### Install Required Tools

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

### Run Simulation

```bash
vvp mux_sim
```

### Open Waveform

```bash
gtkwave tb_good_mux.vcd
```

---

## 5. RTL Synthesis Using Yosys

After simulation, the RTL design was synthesized using **Yosys**.

### Synthesis Command

```bash
yosys -p "read_verilog good_mux.v; hierarchy -top good_mux; proc; opt; techmap; opt; show"
```

This converts the Verilog RTL into a synthesized hardware representation.

---

## 📚 Key Learnings

- Verilog RTL design fundamentals
- Design and testbench concepts
- 2-to-1 Multiplexer implementation
- Verilog compilation and simulation
- VCD waveform generation
- Waveform analysis using GTKWave
- Introduction to RTL synthesis
- Yosys synthesis flow

---

## ✅ Day 1 Outcome

Successfully designed, simulated, verified, and synthesized a **2-to-1 Multiplexer**, gaining practical experience with the basic RTL flow:

**RTL Design → Simulation → Verification → Synthesis**

---

### 📂 Repository Structure

```text
Day1/
├── README.md
├── good_mux.v
└── tb_good_mux.v
```
