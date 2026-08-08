# 🚀 Day 2 — Timing Libraries, Synthesis & Flip-Flops

## 📌 Overview

Day 2 focused on **SKY130 timing libraries, synthesis methods, flip-flop coding styles, and standard-cell mapping**.

---

## 🎯 Topics Covered

- SKY130 `.lib` timing library
- PVT corners
- Hierarchical vs. flattened synthesis
- Flip-flop coding styles
- Icarus Verilog simulation
- Yosys synthesis
- `dfflibmap` and `abc`

---

## 🔹 1. SKY130 Timing Library

The **SKY130 PDK** provides an open-source 130 nm technology library containing standard cells and their timing, power, and capacitance information.

### Library Used

```text
sky130_fd_sc_hd__tt_025C_1v80.lib
```

```text
tt     → Typical process
025C   → 25°C
1v80   → 1.8V supply
```

### Open the Library

```bash
sudo apt install gedit
gedit sky130_fd_sc_hd__tt_025C_1v80.lib
```

---

## 🔹 2. Hierarchical vs Flattened Synthesis

### Hierarchical Synthesis

The module structure is preserved during synthesis.

```text
Top Module
    ↓
Sub Modules
    ↓
Synthesized Design
```

**Advantages →** Easier debugging → Modular design → Better organization

### Flattened Synthesis

The module hierarchy is removed and the complete design is combined.

```text
Multiple Modules
       ↓
    Flatten
       ↓
Single Netlist
```

**Advantages →** Whole-design optimization → Cross-module optimization

| Feature | Hierarchical | Flattened |
|---|---|---|
| Hierarchy | Preserved | Removed |
| Optimization | Module-level | Whole design |
| Debugging | Easier | Harder |
| Large Designs | Manageable | More resource intensive |

---

## 🔹 3. Flip-Flop Coding Styles

### Asynchronous Reset

```verilog
module dff_asyncres (
    input clk,
    input async_reset,
    input d,
    output reg q
);

always @(posedge clk, posedge async_reset)
begin
    if (async_reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
```

```text
async_reset = 1 → q = 0 immediately
async_reset = 0 → q updates on clock edge
```

### Asynchronous Set

```verilog
module dff_async_set (
    input clk,
    input async_set,
    input d,
    output reg q
);

always @(posedge clk, posedge async_set)
begin
    if (async_set)
        q <= 1'b1;
    else
        q <= d;
end

endmodule
```

```text
async_set = 1 → q = 1 immediately
```

### Synchronous Reset

```verilog
module dff_syncres (
    input clk,
    input sync_reset,
    input d,
    output reg q
);

always @(posedge clk)
begin
    if (sync_reset)
        q <= 1'b0;
    else
        q <= d;
end

endmodule
```

```text
sync_reset = 1 → q becomes 0 on clock edge
```

---

## 🔹 4. Simulation

### Compile

```bash
iverilog dff_asyncres.v tb_dff_asyncres.v
```

### Run

```bash
./a.out
```

### View Waveform

```bash
gtkwave tb_dff_asyncres.vcd
```

### Simulation Flow

```text
RTL + Testbench
      ↓
Icarus Verilog
      ↓
Simulation
      ↓
VCD File
      ↓
GTKWave
```

---

## 🔹 5. Yosys Synthesis

**Yosys** is an open-source tool used for RTL synthesis.

### Synthesis Flow

```text
Verilog RTL
     ↓
   Yosys
     ↓
  Synthesis
     ↓
 dfflibmap
     ↓
    ABC
     ↓
Mapped Netlist
```

### Commands

```text
yosys

read_liberty -lib /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
read_verilog dff_asyncres.v
synth -top dff_asyncres
dfflibmap -liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /path/to/sky130_fd_sc_hd__tt_025C_1v80.lib
show
```

### Command Flow

```text
read_liberty
      ↓
read_verilog
      ↓
synth -top
      ↓
dfflibmap
      ↓
abc
      ↓
show
```

**`read_liberty`** → Load standard-cell library  
**`read_verilog`** → Read RTL  
**`synth`** → Perform synthesis  
**`dfflibmap`** → Map flip-flops to library cells  
**`abc`** → Technology mapping and optimization  
**`show`** → Display synthesized design

---

## 📚 Key Learnings

```text
SKY130 Library
      ↓
RTL Design
      ↓
Simulation
      ↓
Synthesis
      ↓
Flip-Flop Mapping
      ↓
Technology Mapping
```

- Understood `.lib` timing libraries
- Learned PVT corner naming
- Compared hierarchical and flattened synthesis
- Studied asynchronous and synchronous flip-flops
- Simulated sequential RTL
- Explored `dfflibmap` and `abc`

---

## 🏁 Day 2 Outcome

**RTL → Simulation → Synthesis → Cell Mapping → Netlist**

Gained a better understanding of how RTL designs are synthesized and mapped to real standard cells.

### ✅ Day 2 Completed
