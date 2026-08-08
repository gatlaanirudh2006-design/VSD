# Day 1 — Verilog RTL Design and Simulation

## Overview

Day 1 was dedicated to getting started with **Verilog RTL design** and understanding the basic hardware development flow. I explored how an RTL design is written, tested with a testbench, simulated, and finally introduced to synthesis.

As a practical exercise, I implemented a **2-to-1 Multiplexer** and verified its functionality using **Icarus Verilog** and **GTKWave**. I also explored the basics of **Yosys** for RTL synthesis.

---

## Topics Covered

- Verilog RTL fundamentals
- Design and testbench
- Digital circuit simulation
- Icarus Verilog
- GTKWave waveform analysis
- 2-to-1 Multiplexer
- RTL synthesis with Yosys

---

## 1. RTL Design and Verification

### RTL Design

RTL (Register Transfer Level) is a way of describing digital hardware using a hardware description language such as Verilog.

The RTL code defines the inputs, outputs, and logic required to implement the desired circuit.

### Testbench
<img width="1212" height="570" alt="image" src="https://github.com/user-attachments/assets/68a383d2-9044-4cfd-be6b-aaa937d30eae" />

A testbench is a separate Verilog module used only for verification. It provides different input combinations to the design and observes the resulting outputs.

### Simulator

A simulator executes the RTL and testbench together and shows how the circuit behaves over simulation time. This allows design errors to be found before moving to actual hardware.

---

## 2. Simulation Using Icarus Verilog
<img width="1402" height="649" alt="image" src="https://github.com/user-attachments/assets/9c20d78c-42e6-4ffc-957e-5b5fb2be606a" />

**Icarus Verilog** is an open-source compiler and simulator used to compile and execute Verilog designs.

The basic workflow used was:

```text
Verilog Design
      +
  Testbench
      ↓
Icarus Verilog
      ↓
   Simulation
      ↓
   VCD File
      ↓
   GTKWave
      ↓
Waveform Analysis
```

---

## 3. Installing the Tools

The required tools can be installed on Ubuntu/Linux using:

```bash
sudo apt update
sudo apt install iverilog
sudo apt install gtkwave
sudo apt install yosys
```

---

## 4. Practical Experiment — 2-to-1 Multiplexer

A 2-to-1 Multiplexer selects one of two inputs depending on the value of a select signal.

### Signals

- `i0` — First data input
- `i1` — Second data input
- `sel` — Select signal
- `y` — Output

### Truth Table

| `sel` | `y` |
|:---:|:---:|
| `0` | `i0` |
| `1` | `i1` |

Therefore:

```text
sel = 0  →  y = i0
sel = 1  →  y = i1
```

---

## 5. Verilog Implementation

The multiplexer was implemented using an `always @(*)` block.

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

### Working

The `sel` signal controls which input is connected to the output.

- If `sel` is `0`, the output receives `i0`.
- If `sel` is `1`, the output receives `i1`.

Since this is combinational logic, the output responds to changes in the input signals.

---

## 6. Compilation and Simulation

Assuming the design and testbench files are:

```text
good_mux.v
tb_good_mux.v
```

### Compile

```bash
iverilog good_mux.v tb_good_mux.v
```

This generates the simulation executable:

```text
a.out
```

### Run

```bash
./a.out
```

If the testbench contains VCD dumping commands, the simulation generates:

```text
tb_good_mux.vcd
```

### Open the Waveform

```bash
gtkwave tb_good_mux.vcd
```

GTKWave can then be used to observe `i0`, `i1`, `sel`, and `y` with respect to simulation time.

---

## 7. Testbench Verification

The testbench applies different combinations of `i0`, `i1`, and `sel` to the multiplexer.

The verification process can be represented as:

```text
Input Stimulus
      ↓
     DUT
  (2:1 MUX)
      ↓
Output Observation
```

The simulation is considered correct when the output follows the selected input:

```text
sel = 0 → y follows i0
sel = 1 → y follows i1
```

---

## 8. Introduction to Yosys

**Yosys** is an open-source RTL synthesis framework. It is used to process Verilog RTL and convert it into a synthesized hardware representation.

The basic synthesis concept is:

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

### Basic Yosys Commands

```text
read_verilog good_mux.v
synth -top good_mux
abc
write_verilog synthesized_mux.v
```

For synthesis using a technology library:

```text
read_liberty -lib <library>.lib
read_verilog good_mux.v
synth -top good_mux
abc -liberty <library>.lib
write_verilog synthesized_mux.v
```

This provided an initial understanding of how RTL code is transformed toward an implementation-level representation.

---

## 9. Complete Day 1 Flow

```text
Write Verilog RTL
        ↓
Create Testbench
        ↓
Compile with Icarus Verilog
        ↓
Run Simulation
        ↓
Generate VCD
        ↓
Analyze using GTKWave
        ↓
Explore RTL Synthesis
        ↓
Yosys
```

---

## 10. Key Learnings

- Understood the basic concept of RTL design.
- Learned the purpose of a design module and testbench.
- Implemented a 2-to-1 Multiplexer using Verilog.
- Compiled and simulated Verilog using Icarus Verilog.
- Generated and analyzed VCD waveform data using GTKWave.
- Understood how simulation helps verify RTL functionality.
- Explored the basic purpose of RTL synthesis.
- Gained an introduction to Yosys and synthesis commands.

---

## Conclusion

Day 1 provided a practical introduction to the **Verilog RTL development flow**. The 2-to-1 Multiplexer was successfully implemented and simulated, and its behavior was verified through waveform analysis.

The session also introduced the next stage of the hardware design process — **RTL synthesis using Yosys**.

### Day 1 Flow

**RTL Design → Testbench → Simulation → Waveform Verification → Synthesis**

---

## Files



**Day 1 Completed ✅**
