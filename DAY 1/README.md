# 🚀 Day 1 — Verilog RTL Design & Simulation

## 📌 Overview

Day 1 focused on the basics of **Verilog RTL Design, Simulation, Verification, and Synthesis**.

As a practical exercise, I implemented a **2-to-1 Multiplexer**, simulated it using **Icarus Verilog**, analyzed the waveform using **GTKWave**, and explored **Yosys** for RTL synthesis.

---

## 🛠️ Tools Used

**Verilog HDL** → RTL Design  
**Icarus Verilog** → Simulation  
**GTKWave** → Waveform Analysis  
**Yosys** → RTL Synthesis  

---

## 🔹 1. RTL Design & Verification
# 🚀 Day 1 — Verilog RTL Design & Simulation

## 📌 Overview

Day 1 focused on the basics of **Verilog RTL Design, Simulation, Verification, and Synthesis**.

As a practical exercise, I implemented a **2-to-1 Multiplexer**, simulated it using **Icarus Verilog**, analyzed the waveform using **GTKWave**, and explored **Yosys** for RTL synthesis.

---

## 🛠️ Tools Used

**Verilog HDL** → RTL Design  
**Icarus Verilog** → Simulation  
**GTKWave** → Waveform Analysis  
**Yosys** → RTL Synthesis  

---

## 🔹 1. RTL Design & Verification

### RTL Design
Verilog is used to describe the required digital hardware and its logic.

### Testbench
A testbench provides input stimulus → observes outputs → verifies the design.

### Simulator
The simulator executes the RTL + testbench → produces simulation results.

---

## 🔹 2. Simulation Flow

```text
Verilog Design
      ↓
  Testbench
      ↓
Icarus Verilog
      ↓
  Simulation
      ↓
   .vcd File
      ↓
   GTKWave
      ↓
Waveform Analysis
```

---

## 🔹 3. Install Required Tools

```bash
sudo apt update
sudo apt install iverilog
sudo apt install gtkwave
sudo apt install yosys
```

---

## 🔹 4. 2-to-1 Multiplexer

A **2:1 MUX** selects one of two inputs using the `sel` signal.

```text
sel = 0  →  y = i0
sel = 1  →  y = i1
```

### Truth Table

| `sel` | `y` |
|:---:|:---:|
| 0 | `i0` |
| 1 | `i1` |

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
    if (sel)
        y <= i1;
    else
        y <= i0;
end

endmodule
```

---

## 🔹 5. Simulation

### Compile

```bash
iverilog good_mux.v tb_good_mux.v
```

### Run

```bash
./a.out
```

### View Waveform

```bash
gtkwave tb_good_mux.vcd
```

### Verification

```text
Input Stimulus
      ↓
    2:1 MUX
      ↓
Output Observation
      ↓
   Verification
```

Expected behavior:

```text
sel = 0 → y follows i0
sel = 1 → y follows i1
```

---

## 🔹 6. Yosys Synthesis

**Yosys** converts Verilog RTL → synthesized hardware representation.

```text
Verilog RTL
     ↓
   Yosys
     ↓
Logic Processing
     ↓
Technology Mapping
     ↓
Synthesized Netlist
```

### Basic Commands

```text
read_verilog good_mux.v
synth -top good_mux
abc
write_verilog synthesized_mux.v
```

---

## 📚 Key Learnings

**Verilog RTL** → Hardware Description  
**Testbench** → Design Verification  
**Icarus Verilog** → Simulation  
**GTKWave** → Waveform Analysis  
**Yosys** → RTL Synthesis  

---

## 🏁 Day 1 Outcome

Successfully implemented and verified a **2-to-1 Multiplexer** and understood the basic RTL development flow:

```text
RTL Design
    ↓
Testbench
    ↓
Simulation
    ↓
Waveform Verification
    ↓
RTL Synthesis
```

### ✅ Day 1 Completed
```text
Day1/
├── README.md
├── good_mux.v
└── tb_good_mux.v
```
### RTL Design
Verilog is used to describe the required digital hardware and its logic.

### Testbench
A testbench provides input stimulus → observes outputs → verifies the design.

### Simulator
The simulator executes the RTL + testbench → produces simulation results.

---

## 🔹 2. Simulation Flow
![Uploading image.png…]()

```text
Verilog Design
      ↓
  Testbench
      ↓
Icarus Verilog
      ↓
  Simulation
      ↓
   .vcd File
      ↓
   GTKWave
      ↓
Waveform Analysis
```

---

## 🔹 3. Install Required Tools

```bash
sudo apt update
sudo apt install iverilog
sudo apt install gtkwave
sudo apt install yosys
```

---

## 🔹 4. 2-to-1 Multiplexer

A **2:1 MUX** selects one of two inputs using the `sel` signal.

```text
sel = 0  →  y = i0
sel = 1  →  y = i1
```

### Truth Table

| `sel` | `y` |
|:---:|:---:|
| 0 | `i0` |
| 1 | `i1` |

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
    if (sel)
        y <= i1;
    else
        y <= i0;
end

endmodule
```

---

## 🔹 5. Simulation

### Compile

```bash
iverilog good_mux.v tb_good_mux.v
```

### Run

```bash
./a.out
```

### View Waveform

```bash
gtkwave tb_good_mux.vcd
```

### Verification

```text
Input Stimulus
      ↓
    2:1 MUX
      ↓
Output Observation
      ↓
   Verification
```

Expected behavior:

```text
sel = 0 → y follows i0
sel = 1 → y follows i1
```

---

## 🔹 6. Yosys Synthesis

**Yosys** converts Verilog RTL → synthesized hardware representation.

```text
Verilog RTL
     ↓
   Yosys
     ↓
Logic Processing
     ↓
Technology Mapping
     ↓
Synthesized Netlist
```

### Basic Commands

```text
read_verilog good_mux.v
synth -top good_mux
abc
write_verilog synthesized_mux.v
```

---

## 📚 Key Learnings

**Verilog RTL** → Hardware Description  
**Testbench** → Design Verification  
**Icarus Verilog** → Simulation  
**GTKWave** → Waveform Analysis  
**Yosys** → RTL Synthesis  

---

## 🏁 Day 1 Outcome

Successfully implemented and verified a **2-to-1 Multiplexer** and understood the basic RTL development flow:

```text
RTL Design
    ↓
Testbench
    ↓
Simulation
    ↓
Waveform Verification
    ↓
RTL Synthesis
```

### ✅ Day 1 Completed
