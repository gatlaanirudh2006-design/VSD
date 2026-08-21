# 🔄 Day 4 – Gate Level Simulation and Synthesis-Simulation Mismatch

This section focuses on **Gate Level Simulation (GLS)** and understanding situations where **RTL simulation results can differ from the behavior of the synthesized design**.

The experiments were performed using:

* 🔹 Icarus Verilog
* 🔹 GTKWave
* 🔹 Yosys
* 🔹 SKY130 standard-cell libraries

---

## 🎯 Objective

The objective is to understand:

* 🔹 Gate Level Simulation (GLS)
* 🔹 RTL simulation vs synthesized netlist simulation
* 🔹 Synthesis-simulation mismatch
* 🔹 Missing sensitivity lists
* 🔹 Blocking vs non-blocking assignments
* 🔹 Blocking assignment caveats
* 🔹 Ternary operator implementation of a MUX
* 🔹 Technology-specific gate-level netlists

---

# 📚 Topics Covered

* 🔧 Gate Level Simulation (GLS)
* 🔄 RTL simulation vs synthesized netlist simulation
* ⚠️ Synthesis-simulation mismatch
* 🧩 Missing sensitivity list
* ⚙️ Blocking vs non-blocking assignments
* ⚠️ Blocking assignment caveat
* 🔀 Ternary operator implementation of a MUX

---

# 1️⃣ Gate Level Simulation

## 🧩 What is GLS?

**Gate Level Simulation (GLS)** verifies the behavior of the **synthesized gate-level netlist** using a testbench.

Unlike RTL simulation, the synthesized netlist contains **technology-specific standard-cell instances** from the SKY130 library.

### 🔄 General Flow

```text
        RTL Design
             ↓
        RTL Simulation
             ↓
       Yosys Synthesis
             ↓
      Technology Mapping
             ↓
     Gate-Level Netlist
             ↓
    Gate Level Simulation
             ↓
      Compare with RTL
```

### 💡 Why GLS is Important

GLS helps verify whether the synthesized implementation preserves the intended functionality of the RTL design.

It can reveal problems caused by:

* ⚠️ Incorrect RTL coding
* ⚠️ Synthesis-simulation mismatches
* ⚠️ Incorrect procedural behavior
* ⚠️ Technology mapping issues

---

# 2️⃣ 🔀 Ternary Operator MUX

A **2:1 multiplexer** can be described using the Verilog ternary operator:

```verilog
assign y = sel ? i1 : i0;
```

The expression means:

```text
             sel
              │
        ┌─────┴─────┐
        │           │
       i1           i0
        │           │
        └─────┬─────┘
              ↓
              y
```

When:

* `sel = 1` → `y = i1`
* `sel = 0` → `y = i0`

### 🏭 Synthesized Cell

The synthesized design was mapped to the SKY130 standard-cell MUX:

```text
sky130_fd_sc_hd__mux2_1
```

---

## 🔍 Evidence

### RTL Simulation

The RTL simulation verifies the functional behavior of the MUX before synthesis.

### 🏭 Synthesized Logic

The synthesized design shows the corresponding SKY130 standard-cell implementation.

### 🌊 Gate Level Simulation

The gate-level simulation verifies the behavior of the synthesized MUX.

> ✅ The RTL simulation and GLS waveforms show consistent MUX functionality.

---

# 3️⃣ ⚠️ Missing Sensitivity List – Bad MUX

The `bad_mux` experiment demonstrates a **synthesis-simulation mismatch** caused by an incomplete sensitivity list.

The RTL simulation does not respond correctly to all input changes because the `always` block is sensitive only to the select signal.

However, synthesis analyzes the intended combinational logic and implements the MUX structure.

This can result in different behavior between:

```text
RTL Simulation
       ↕
Gate Level Simulation
```

### 🧠 Key Learning

For combinational logic, the sensitivity list must include **all signals that affect the output**.

A recommended approach is:

```verilog
always @(*)
```

This allows the simulator to evaluate the block whenever any relevant input changes.

### ⚠️ Problem

An incomplete sensitivity list can cause:

```text
Input changes
     ↓
Sensitivity list does not trigger
     ↓
Output does not update
     ↓
RTL simulation gives incorrect behavior
```

while synthesis may still infer the intended combinational hardware.

---

# 4️⃣ ⚙️ Blocking Assignment Caveat

The `blocking_caveat` experiment demonstrates how the **ordering of blocking assignments** can produce different RTL simulation behavior compared with synthesized hardware.

Blocking assignments use:

```verilog
=
```

and are executed sequentially in the order in which they appear.

### ⚠️ Important Point

For combinational logic, incorrect ordering can cause the simulator to use an **old value of an intermediate signal**.

This can result in:

```text
RTL Simulation
      ≠
Synthesized Logic
```

### 🔍 Comparison

The experiment demonstrates:

* 🌊 RTL Simulation
* 🏭 Synthesized Logic
* 🌊 Gate Level Simulation

The synthesized implementation represents the combinational logic directly, while RTL simulation can exhibit different behavior because of **procedural evaluation order**.

---

# 5️⃣ ⚖️ Blocking vs Non-Blocking Assignments

Understanding the difference between blocking and non-blocking assignments is important for writing reliable RTL.

## 🔹 Blocking Assignment

```verilog
=
```

Characteristics:

* Statements execute sequentially.
* The next statement sees the updated value.
* Commonly used for combinational logic.

Example:

```verilog
always @(*) begin
    a = b;
    c = a;
end
```

Here, `c` sees the updated value of `a`.

---

## 🔹 Non-Blocking Assignment

```verilog
<=
```

Characteristics:

* Updates are scheduled rather than immediately applied.
* Commonly used for sequential logic.
* Helps model flip-flop behavior correctly.

Example:

```verilog
always @(posedge clk) begin
    q <= d;
end
```

---

## 📌 General RTL Guideline

| **Logic Type**         | **Recommended Assignment** |
| ---------------------- | -------------------------- |
| 🔧 Combinational Logic | Blocking `=`               |
| 🔄 Sequential Logic    | Non-Blocking `<=`          |

> 💡 Following this guideline helps avoid unexpected simulation behavior and makes RTL easier to synthesize and verify.

---

# 🔄 RTL vs Gate-Level Simulation

The overall verification flow can be represented as:

```text
             RTL Design
                 │
                 ▼
          RTL Simulation
                 │
                 ▼
          Yosys Synthesis
                 │
                 ▼
        Technology Mapping
                 │
                 ▼
       Gate-Level Netlist
                 │
                 ▼
       Gate-Level Simulation
                 │
                 ▼
       Compare Both Results
```

### 🎯 Goal

The main goal is to ensure:

```text
RTL Behavior
     ↓
    MATCH
     ↓
Gate-Level Behavior
```

If the behaviors do not match, the RTL coding style, synthesis process, or technology mapping should be investigated.

---

# 🧠 Key Takeaways

GLS provides an important verification step after synthesis.

### ✅ Important Points

* 🔹 GLS verifies the synthesized gate-level implementation.
* 🔹 RTL simulation and synthesized-netlist simulation can differ because of RTL coding issues.
* 🔹 Missing sensitivity lists can cause synthesis-simulation mismatches.
* 🔹 Blocking assignments execute in procedural order.
* 🔹 Incorrect ordering of blocking assignments can cause unexpected RTL simulation behavior.
* 🔹 Ternary operators provide a concise way to describe MUX logic.
* 🔹 SKY130 standard-cell mapping converts RTL constructs into technology-specific cells.
* 🔹 Comparing RTL simulation with GLS helps identify functional mismatches.

---

# 🛠️ Tools Used

| **Tool / Technology**            | **Purpose**                      |
| -------------------------------- | -------------------------------- |
| **Icarus Verilog**               | RTL and gate-level simulation    |
| **GTKWave**                      | Waveform visualization           |
| **Yosys**                        | RTL synthesis and optimization   |
| **SKY130 Standard-Cell Library** | Technology mapping               |
| **Linux**                        | Development environment          |
| **VSDIAT Workshop Environment**  | Design and synthesis environment |

---

# 📌 Day 4 Summary

### 📚 Topic

**Gate Level Simulation and Synthesis-Simulation Mismatch**

### 🔑 Main Concepts

**RTL Simulation → Synthesis → Technology Mapping → Gate-Level Netlist → GLS → Verification**

> 🚀 **Key takeaway:** Gate Level Simulation helps verify that the synthesized hardware behaves as intended and highlights important RTL coding practices that can prevent synthesis-simulation mismatches.

