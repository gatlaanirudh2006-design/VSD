# 🚀 Day 1 — Verilog RTL Design & Simulation

## 📌 Overview

Day 1 focused on **Verilog RTL Design, Simulation, Verification, and basic Synthesis**.

Implemented and simulated a **2-to-1 Multiplexer** using **Icarus Verilog**, analyzed the waveform with **GTKWave**, and explored **Yosys** synthesis.

---

## 🛠️ Tools

**Verilog** → RTL Design  
**Icarus Verilog** → Simulation  
**GTKWave** → Waveform Analysis  
**Yosys** → Synthesis  

---

## 🔹 1. RTL & Testbench
<img width="1212" height="570" alt="image" src="https://github.com/user-attachments/assets/2c258afb-ca24-47c1-8a02-12cb93562004" />

```text
RTL Design
    ↓
Testbench
    ↓
Simulation
    ↓
Verification
```

A testbench applies inputs to the design and checks the output.

---

## 🔹 2. 2:1 Multiplexer

```text
sel = 0 → y = i0
sel = 1 → y = i1
```

### Verilog

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

## 🔹 3. Simulation
<img width="1402" height="649" alt="image" src="https://github.com/user-attachments/assets/75e05595-dcf4-4eb6-981f-465d6613f599" />


### Install

```bash
sudo apt update
sudo apt install iverilog gtkwave yosys
```

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

### Flow

```text
Verilog + Testbench
        ↓
  Icarus Verilog
        ↓
    .vcd File
        ↓
     GTKWave
```

---

## 🔹 4. Yosys Synthesis

```text
Verilog RTL
     ↓
   Yosys
     ↓
  Synthesis
     ↓
Technology Mapping
     ↓
 Synthesized Netlist
```

### Commands

```text
read_liberty -lib <library>.lib
read_verilog good_mux.v
synth -top good_mux
abc -liberty <library>.lib
write_verilog synthesized_mux.v
```

---

## 📚 Key Learnings

- Verilog RTL design
- Testbench and simulation
- 2:1 Multiplexer
- Icarus Verilog
- GTKWave
- Yosys synthesis
- ABC technology mapping

---

## 🏁 Day 1 Outcome

**RTL Design → Simulation → Verification → Synthesis**

Successfully designed and verified a **2:1 Multiplexer** using Verilog and gained hands-on experience with the basic RTL flow.

### ✅ Day 1 Completed
