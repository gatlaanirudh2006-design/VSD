# 🚀 Day 1 — Verilog RTL Design, Simulation & Synthesis

## 📌 Overview

Day 1 was focused on understanding the fundamentals of **Verilog RTL Design**, simulation, verification, and synthesis.

As a practical implementation, I designed a **2-to-1 Multiplexer**, created its testbench, simulated it using **Icarus Verilog**, analyzed the waveform using **GTKWave**, and explored the synthesized design using **Yosys**.

---

## 🎯 Objectives

- Understand the basics of RTL design
- Learn Verilog HDL syntax
- Understand the role of a testbench
- Simulate Verilog designs using Icarus Verilog
- Analyze waveforms using GTKWave
- Implement a 2-to-1 Multiplexer
- Understand the basics of RTL synthesis using Yosys

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| Verilog HDL | RTL hardware description |
| Icarus Verilog | Compilation and simulation |
| GTKWave | Waveform visualization |
| Yosys | RTL synthesis |

---

# 1️⃣ Design, Testbench and Simulator

### Design

The **Design Under Test (DUT)** is the actual Verilog module that describes the required hardware functionality.

For this experiment, the DUT is a **2-to-1 Multiplexer**.

### Testbench

The testbench generates different input combinations and applies them to the DUT. The output is monitored to verify whether the design behaves correctly.

### Simulator

A simulator executes the Verilog design and testbench and provides the behavior of the circuit over simulation time.

---

# 2️⃣ Icarus Verilog Simulation Flow

The complete simulation flow used in this experiment was:

```text
          Verilog Design
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
```

---

# 3️⃣ Installing the Required Tools

### Install Icarus Verilog

```bash
sudo apt update
sudo apt install iverilog
```

### Install GTKWave

```bash
sudo apt install gtkwave
```

### Install Yosys

```bash
sudo apt install yosys
```

---

# 4️⃣ 2-to-1 Multiplexer

A **2-to-1 Multiplexer** selects one of two inputs based on a select signal.

### Inputs

- `i0` → Input 0
- `i1` → Input 1
- `sel` → Select signal

### Output

- `y` → Selected output

### Truth Table

| `sel` | `y` |
|:---:|:---:|
| 0 | `i0` |
| 1 | `i1` |

---

# 5️⃣ Verilog RTL Code

Create a file named:

```text
good_mux.v
```

Use the following code:

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

### Working

When:

```text
sel = 0
```

the output is:

```text
y = i0
```

When:

```text
sel = 1
```

the output is:

```text
y = i1
```

---

# 6️⃣ Testbench

Create another file:

```text
tb_good_mux.v
```

Example testbench:

```verilog
`timescale 1ns/1ps

module tb_good_mux;

reg i0;
reg i1;
reg sel;
wire y;

good_mux uut (
    .i0(i0),
    .i1(i1),
    .sel(sel),
    .y(y)
);

initial begin

    $dumpfile("tb_good_mux.vcd");
    $dumpvars(0, tb_good_mux);

    i0 = 0;
    i1 = 0;
    sel = 0;
    #10;

    i0 = 1;
    i1 = 0;
    sel = 0;
    #10;

    i0 = 0;
    i1 = 1;
    sel = 1;
    #10;

    i0 = 1;
    i1 = 0;
    sel = 1;
    #10;

    i0 = 1;
    i1 = 1;
    sel = 0;
    #10;

    $finish;

end

endmodule
```

---

# 7️⃣ Simulation Commands

## Step 1 — Compile

Compile both the design and testbench:

```bash
iverilog -o mux_sim good_mux.v tb_good_mux.v
```

## Step 2 — Run Simulation

```bash
vvp mux_sim
```

This generates:

```text
tb_good_mux.vcd
```

## Step 3 — Open Waveform

```bash
gtkwave tb_good_mux.vcd
```

The waveform can then be inspected to verify the relationship between `i0`, `i1`, `sel`, and `y`.

---

# 8️⃣ Quick Simulation Command

The complete simulation can also be performed using:

```bash
iverilog -o mux_sim good_mux.v tb_good_mux.v
vvp mux_sim
gtkwave tb_good_mux.vcd
```

---

# 9️⃣ Yosys RTL Synthesis

After verifying the design through simulation, the RTL was synthesized using **Yosys**.

### Start Yosys

```bash
yosys
```

Inside Yosys, read the Verilog file:

```text
read_verilog good_mux.v
```

Select the top module:

```text
hierarchy -top good_mux
```

Convert the design into RTLIL:

```text
proc
```

Perform optimization:

```text
opt
```

Technology mapping:

```text
techmap
```

Optimize again:

```text
opt
```

Write the synthesized netlist:

```text
write_verilog synthesized_mux.v
```

Exit Yosys:

```text
exit
```

---

# 🔟 Yosys Synthesis — Complete Command

Instead of entering the commands one by one, the complete synthesis flow can be executed using:

```bash
yosys -p "read_verilog good_mux.v; hierarchy -top good_mux; proc; opt; techmap; opt; write_verilog synthesized_mux.v"
```

This generates:

```text
synthesized_mux.v
```

---

# 1️⃣1️⃣ Generate Synthesized Schematic

Yosys can also generate a schematic representation.

Run:

```bash
yosys
```

Then:

```text
read_verilog good_mux.v
hierarchy -top good_mux
proc
opt
show
```

The synthesized design can then be viewed using the graphical viewer.

The resulting structure shows the relationship between:

```text
i0  → A0
i1  → A1
sel → S
y   ← X
```

---

# 1️⃣2️⃣ Complete Day 1 Command List

For quick reference, all the important commands used during Day 1 are:

### Install tools

```bash
sudo apt update
sudo apt install iverilog
sudo apt install gtkwave
sudo apt install yosys
```

### Compile Verilog

```bash
iverilog -o mux_sim good_mux.v tb_good_mux.v
```

### Run simulation

```bash
vvp mux_sim
```

### Open waveform

```bash
gtkwave tb_good_mux.vcd
```

### Synthesize using Yosys

```bash
yosys -p "read_verilog good_mux.v; hierarchy -top good_mux; proc; opt; techmap; opt; write_verilog synthesized_mux.v"
```

### Open Yosys

```bash
yosys
```

### Generate schematic inside Yosys

```text
read_verilog good_mux.v
hierarchy -top good_mux
proc
opt
show
```

---

# 1️⃣3️⃣ Verification Result

The simulation confirmed the expected multiplexer behavior:

```text
sel = 0  →  y = i0
sel = 1  →  y = i1
```

The waveform obtained from GTKWave was used to verify the output transitions.

The Yosys synthesis step demonstrated how the Verilog RTL description can be converted into a synthesized hardware representation.

---

# 📚 Key Learnings

During Day 1, I gained practical experience in:

- Verilog RTL coding
- Writing a testbench
- Understanding combinational logic
- Implementing a 2-to-1 Multiplexer
- Compiling Verilog using Icarus Verilog
- Running RTL simulations
- Generating VCD waveform files
- Analyzing waveforms using GTKWave
- Understanding RTL synthesis
- Using Yosys for synthesis
- Viewing the synthesized hardware structure

---

# 🏁 Day 1 Outcome

> **Successfully designed, simulated, verified, and synthesized a 2-to-1 Multiplexer using Verilog HDL, Icarus Verilog, GTKWave, and Yosys.**

This experiment provided a practical introduction to the complete flow from **RTL coding → simulation → waveform verification → synthesis**.

---

## 📂 Day 1 Repository Structure

```text
Day1/
│
├── README.md
├── good_mux.v
├── tb_good_mux.v
├── tb_good_mux.vcd
└── synthesized_mux.v
```

---

### ✅ Day 1 Complete

**Verilog RTL Design → Simulation → Verification → Synthesis**
