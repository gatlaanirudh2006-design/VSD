# 🔄 Module 3 – Sequential Optimization

This section demonstrates **sequential logic optimization** using a **3-bit counter** and Yosys.

The example shows how the output logic associated with a counter can be represented differently and how Yosys processes the resulting sequential design.

---

## 🎯 Objective

The objective is to understand:

* 🔹 3-bit counter operation
* 🔹 Sequential RTL synthesis
* 🔹 Counter output logic
* 🔹 Boolean optimization
* 🔹 Technology mapping using Yosys
* 🔹 Synthesized circuit representation

### 📂 Example Used

* `counter_opt.v`

> ℹ️ **Note:** GTKWave is optional for this exercise. The main focus is on RTL structure, synthesis, and optimization.

---

# 1️⃣ Normal Design

## 🧩 RTL Code

```verilog
module counter_opt (input clk, input reset, output q);

reg [2:0] count;

assign q = count[0];

always @(posedge clk, posedge reset)
begin
    if (reset)
        count <= 3'b000;
    else
        count <= count + 1;
end

endmodule
```

## ⚙️ Operation

The counter is **3 bits wide**:

```text
count[2:0]
```

The counter increments on every positive edge of the clock.

When `reset` is active:

```text
count = 000
```

Otherwise:

```text
count = count + 1
```

The normal design connects the output directly to the least-significant bit:

```verilog
assign q = count[0];
```

Therefore, `q` follows the **least-significant bit (LSB)** of the counter.

### 📊 Counter Sequence

| **Count** | **q = count[0]** |
| --------- | ---------------: |
| `000`     |                0 |
| `001`     |                1 |
| `010`     |                0 |
| `011`     |                1 |
| `100`     |                0 |
| `101`     |                1 |
| `110`     |                0 |
| `111`     |                1 |

---

# 2️⃣ Optimized / Reference Design

## 🧩 RTL Code

```verilog
module counter_opt (input clk, input reset, output q);

reg [2:0] count;

assign q = (count[2:0] == 3'b100);

always @(posedge clk, posedge reset)
begin
    if (reset)
        count <= 3'b000;
    else
        count <= count + 1;
end

endmodule
```

## ⚙️ Optimization

The output is changed to a comparison with a specific counter value:

```verilog
assign q = (count[2:0] == 3'b100);
```

The output becomes HIGH only when the counter reaches binary `100`.

### 📊 Output Table

| **`count[2:0]`** | **q** |
| ---------------- | ----: |
| `000`            |     0 |
| `001`            |     0 |
| `010`            |     0 |
| `011`            |     0 |
| `100`            |     1 |
| `101`            |     0 |
| `110`            |     0 |
| `111`            |     0 |

> 💡 **Important:** The comparison-based design has different output behavior from the normal `count[0]` version. It is treated as the optimized/reference form used in this exercise.

---

# 🛠️ Yosys Synthesis

The design can be synthesized and optimized using **Yosys**.

---

## 1️⃣ Step 1 – Go to the Design Directory

```bash
cd ~/VSDIAT/Module_3/Seq_Optimised
```

Check the files:

```bash
ls
```

You should have:

```text
counter_opt.v
```

---

## 2️⃣ Step 2 – Start Yosys

```bash
yosys
```

---

## 3️⃣ Step 3 – Read the RTL

```text
read_verilog counter_opt.v
```

---

## 4️⃣ Step 4 – Set the Top Module

```text
prep -top counter_opt
```

---

## 5️⃣ Step 5 – Run Optimization

```text
proc
opt
opt_clean
```

### 🔧 Technology Mapping

```text
techmap
opt
abc
opt_clean
```

For SKY130 technology mapping:

```text
abc -liberty <path-to-sky130-liberty-file>
```

> 💡 Replace `<path-to-sky130-liberty-file>` with the actual SKY130 Liberty file available in your environment.

---

## 6️⃣ Step 6 – View Statistics

```text
stat
```

The statistics show:

* 📊 Number of wires
* 📊 Number of cells
* 📊 Sequential elements
* 📊 Logic elements
* 📊 Overall synthesized structure

---

# 👀 View the Synthesized Circuit

Use:

```text
show
```

Yosys will generate a graphical representation of the synthesized circuit using **Graphviz**.

The synthesized design can be compared with the original RTL to observe how the sequential logic is represented after optimization.

---

# 🌊 GTKWave

GTKWave can be used when a **testbench and VCD waveform** are available.

Example:

```bash
gtkwave dump.vcd
```

The waveform can be used to observe:

* ⏱️ Clock behavior
* 🔄 Counter transitions
* 🔢 Counter values
* 📌 Output `q`

> ℹ️ **GTKWave is optional for this exercise. The primary focus is RTL and synthesis optimization.**

---

# 🧠 Key Observation

This example demonstrates how the output of sequential logic depends on how the internal counter state is used.

## 🔹 Normal Version

```verilog
assign q = count[0];
```

The output depends only on the **least-significant bit** of the counter.

```text
000 → 0
001 → 1
010 → 0
011 → 1
100 → 0
101 → 1
110 → 0
111 → 1
```

---

## 🔹 Optimized / Reference Version

```verilog
assign q = (count[2:0] == 3'b100);
```

The output is asserted only when the counter reaches:

```text
100
```

```text
000 → 0
001 → 0
010 → 0
011 → 0
100 → 1
101 → 0
110 → 0
111 → 0
```

The synthesized circuit therefore contains logic required to detect the specified counter value.

---

# 🔄 Sequential Optimization Flow

```text
        RTL Verilog
             ↓
       Read RTL in Yosys
             ↓
   Process Sequential Logic
             ↓
      Boolean Optimization
             ↓
      Technology Mapping
             ↓
       Optimized Netlist
             ↓
      Synthesized Circuit
```

---

# 🛠️ Tools Used

| **Tool**           | **Purpose**                       |
| ------------------ | --------------------------------- |
| **Verilog HDL**    | RTL description                   |
| **Yosys**          | RTL synthesis and optimization    |
| **Graphviz**       | Synthesized circuit visualization |
| **GTKWave**        | Optional waveform visualization   |
| **SKY130 Library** | Technology mapping                |

---

# 📌 Module 3

**Module 3 – Sequential Optimization**

### 📚 Topic

**Sequential Optimization – Counter Logic**

---

# ✅ Conclusion

The `counter_opt` example demonstrates how a **3-bit sequential counter** can be analyzed and optimized using Yosys.

The normal design generates the output directly from the counter's least-significant bit, while the reference design generates the output by detecting a specific counter state.

Through this exercise, we understand the relationship between:

**RTL → Sequential Logic → Yosys Optimization → Technology Mapping → Synthesized Circuit**

> 🚀 **Key takeaway:** Yosys analyzes RTL behavior and provides a way to optimize and inspect the resulting sequential hardware.

