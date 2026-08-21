# 🚀 Module 3 – Combinational Optimization

This section demonstrates basic **combinational logic optimization** using **Yosys** and the **SKY130 standard-cell library**.

---

## 🎯 Objective

The objective is to understand how **Yosys optimizes combinational RTL** and maps the optimized logic to **SKY130 standard cells**.

### 📂 Examples Used

* `opt_check.v`
* `opt_check2.v`
* `opt_check3.v`

> ℹ️ **Note:** No simulation is required for these examples.

---

# 1️⃣ `opt_check`

## 🧩 RTL

```verilog
module opt_check(input a, input b, output y);
    assign y = a & b;
endmodule
```

### 🔍 Description

The RTL describes a simple **2-input AND operation**.

## ⚙️ Expected Optimized Hardware

After synthesis and technology mapping, the AND operation is represented using the SKY130 AND standard cell:

```text
sky130_fd_sc_hd__and2_0
```

### 📌 Synthesis Result

The synthesis result contains:

* 🔹 Inputs: `a`, `b`
* 🔹 One AND2 standard cell
* 🔹 Output: `y`

---

# 2️⃣ `opt_check2`

The second example demonstrates another simple **combinational expression** and allows Yosys to perform Boolean optimization before technology mapping.

> 📌 **Use the RTL exactly as provided in the source exercise.**

---

# 3️⃣ `opt_check3`

## 🧩 RTL Structure

`opt_check3` contains three inputs (`a`, `b`, `c`) and output `y`, with the logic divided into submodules.

The synthesized result is optimized to a single SKY130 AND3 cell:

```text
sky130_fd_sc_hd__and3_1
```

## ⚙️ Optimized Structure

```text
a ─────┐
b ─────┼──> sky130_fd_sc_hd__and3_1 ──> y
c ─────┘
```

### 💡 Key Observation

Yosys can optimize the RTL logic **across the described structure** and map the required Boolean function to an appropriate standard cell.

---

# ⚙️ Yosys Execution

## 1️⃣ Step 1 – Enter the Working Directory

Navigate to the combinational optimization folder:

```bash
cd <your-combinational-optimization-folder>
```

### 📂 Check the Files

```bash
ls
```

You should have the required Verilog files:

```text
opt_check.v
opt_check2.v
opt_check3.v
```

---

## 2️⃣ Step 2 – Open Yosys

Start Yosys:

```bash
yosys
```

Inside Yosys, read the RTL:

```text
read_verilog opt_check.v
```

### 🔧 Run RTL Optimization

```text
opt
```

### 👀 Display the Optimized Design

```text
show
```

### 🚪 Exit Yosys

```text
exit
```

---

# 🏭 Synthesis and SKY130 Mapping

The design can then be synthesized and mapped using the **SKY130 standard-cell library**.

A typical Yosys flow is:

```bash
yosys
```

Then execute:

```text
read_verilog opt_check.v
hierarchy -top opt_check
proc
opt
techmap
opt
abc -liberty <path-to-sky130-liberty-file>
opt
show
```

### 📚 SKY130 Liberty File

Replace:

```text
<path-to-sky130-liberty-file>
```

with the actual SKY130 Liberty file available in your environment.

For example, the SKY130 HD library used in the exercise is:

```text
sky130_fd_sc_hd__tt_025C_1v80.lib
```

---

# 👀 Viewing the Synthesized Design

Yosys can generate a graphical representation of the synthesized netlist using:

```text
show
```

The generated schematic can then be viewed in the graphical viewer.

## 🔹 `opt_check` Result

The optimized design is represented by:

```text
sky130_fd_sc_hd__and2_0
```

## 🔹 `opt_check3` Result

The optimized design is represented by:

```text
sky130_fd_sc_hd__and3_1
```

### ✅ Key Result

These results demonstrate **technology mapping** from RTL Boolean logic to **SKY130 standard cells**.

---

# 🌊 GTKWave

GTKWave is normally used to view **simulation waveforms**.

For this combinational optimization exercise:

> ⚠️ **Simulation and waveform generation are not required.**

If a VCD waveform is generated later, it can be opened using:

```bash
gtkwave <waveform>.vcd
```

For example:

```bash
gtkwave opt_check.vcd
```

The required signals can then be added to the waveform window for observation.

---

# 🧠 Optimization Concept

The overall optimization flow is:

```text
        RTL Verilog
             │
             ▼
         Read RTL
             │
             ▼
     Yosys Optimization
             │
             ▼
   Boolean Logic Optimization
             │
             ▼
     Technology Mapping
             │
             ▼
    SKY130 Standard Cell
             │
             ▼
      Optimized Netlist
```

### 💡 Important Concept

The synthesis tool does **not simply preserve the RTL structure**.

Instead, it:

1. 🔍 Analyzes the Boolean logic
2. ⚙️ Optimizes the logic
3. 🏭 Maps the logic to the target technology
4. 📦 Produces an optimized netlist using suitable standard cells

---

# 📊 Results

| **Design**   | **Inputs** | **Output** | **Optimized SKY130 Cell / Result** |
| ------------ | ---------- | ---------- | ---------------------------------- |
| `opt_check`  | `a, b`     | `y`        | `sky130_fd_sc_hd__and2_0`          |
| `opt_check2` | `a, b`     | `y`        | Combinational optimization         |
| `opt_check3` | `a, b, c`  | `y`        | `sky130_fd_sc_hd__and3_1`          |

---

# ✅ Conclusion

The combinational optimization examples demonstrate how **Yosys simplifies RTL logic** and maps the resulting Boolean function to **SKY130 standard cells**.

Simple logic such as AND operations can be directly represented by appropriate library cells.

The `opt_check3` example also demonstrates how Yosys can optimize logic described using **multiple RTL levels** into a compact standard-cell implementation.

### 🎓 What This Exercise Teaches

* 🧩 RTL Boolean logic
* ⚙️ Logic optimization using Yosys
* 🔄 Technology mapping
* 🏭 SKY130 standard-cell usage
* 📦 Optimized netlist generation
* 🔗 Relationship between RTL, synthesis, and target technology

> 🚀 **Overall:** This exercise provides a basic understanding of the relationship between **RTL description → logic optimization → synthesis → technology mapping → standard-cell implementation**.


