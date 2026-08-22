# Day 5 – RTL Constructs, Case/If Statements and Synthesis

## 🎯 Overview

Day 5 focused on understanding how different **Verilog RTL coding constructs** are interpreted during simulation and synthesized into hardware.

The experiments covered:

- 🔹 `if` and `case` based combinational logic
- 🔹 Incomplete conditional assignments
- ⚠️ Latch inference
- 🔀 MUX and DEMUX implementations
- 🧩 Generate-based RTL structures
- 🔹 Partial case assignments
- ➕ Ripple Carry Adder
- 🔬 RTL simulation and synthesis analysis

The experiments were performed using **Verilog HDL**, **GTKWave** for waveform analysis, and **Yosys** with the **SKY130 standard-cell library** for synthesis and structural analysis.

---

# 📚 Topics Covered

- 🔧 RTL constructs
- 🔹 `if` based combinational logic
- 🔹 `case` based combinational logic
- 🔀 MUX and DEMUX implementations
- ⚠️ Incomplete conditional assignments
- ⚠️ Latch inference
- 🧩 Generate-based RTL structures
- 🔹 Partial case assignments
- ➕ Ripple Carry Adder
- 🔬 RTL simulation and synthesis analysis

---

# 1️⃣ Bad Case

The `bad_case` experiment demonstrates **case-based combinational logic** and its synthesized hardware representation.

The experiment helps understand how a `case` statement is interpreted by the synthesis tool and how the resulting combinational hardware is represented.

### 🧠 Key Concept

A `case` statement allows different output values to be selected based on input conditions.

The general flow is:

```text
Input Conditions
      ↓
Case Logic
      ↓
Combinational Logic
      ↓
Synthesized Hardware
```

The experiment demonstrates how RTL written using a `case` construct is converted into hardware during synthesis.

---

# 2️⃣ 🔹 Case-Based Combinational Logic

The `comp_case` experiment demonstrates a **case-based combinational design** and its synthesized implementation.

The experiment focuses on understanding how different input conditions described using a `case` statement are converted into combinational hardware.

### ⚙️ Operation

```text
        Inputs
           ↓
     Case Statement
           ↓
    Condition Selection
           ↓
    Combinational Logic
           ↓
         Output
```

### 🧠 Key Learning

A properly written `case` statement can be synthesized into appropriate combinational logic.

For combinational designs, all required conditions should be handled to avoid unintended storage elements.

---

# 3️⃣ 🔀 DEMUX Using Case Logic

The `demux_case` experiment demonstrates a **demultiplexer implemented using case-based RTL**.

A DEMUX routes a single input to one of several outputs depending on the select signals.

### ⚙️ Basic Operation

```text
              Select
                │
                ▼
Input ───────► DEMUX
                │
       ┌────────┼────────┐
       ▼        ▼        ▼
      Y0       Y1       Y2 ...
```

Only the selected output receives the input signal while the remaining outputs remain inactive.

### 🧠 Key Learning

A DEMUX can be described using a Verilog `case` statement and synthesized into combinational hardware.

The experiment demonstrates how a higher-level RTL description can be converted into the corresponding hardware structure.

---

# 4️⃣ ⚠️ Incomplete `if` Assignment and Latch Inference

The `incomp_if` experiment demonstrates the effect of **incomplete assignments** in combinational RTL and the resulting **latch inference** during synthesis.

### 🧩 Important Concept

For combinational logic, the output should normally be assigned for **all possible input conditions**.

If an output is not assigned in every required condition, the synthesis tool may infer a **latch**.

### ⚠️ Latch Inference

```text
Incomplete Assignment
          ↓
Output must retain
previous value
          ↓
   Storage Required
          ↓
        LATCH
```

### 🧠 Key Learning

Incomplete combinational assignments can unintentionally create storage elements.

Therefore, combinational RTL should be written carefully to avoid unintended latches.

---

# 5️⃣ ⚠️ Incomplete `if` – Second Case

The `incomp_if2` experiment provides another example of **incomplete conditional assignment** and its synthesized implementation.

This experiment further demonstrates how the absence of complete assignments can affect the resulting hardware.

### 🔍 Observation

```text
Complete Assignment
        ↓
Combinational Logic
        ↓
Expected Hardware
```

Whereas:

```text
Incomplete Assignment
        ↓
Output must retain value
        ↓
Possible Latch Inference
```

### 🧠 Key Learning

The synthesis tool interprets incomplete combinational assignments as a requirement to preserve the previous output value.

This can result in a latch being inferred.

---

# 6️⃣ 🧩 MUX Using Generate

The `mux_generate` experiment demonstrates a **multiplexer implementation using generate-based RTL construction**.

The `generate` construct can be used to create repeated hardware structures efficiently.

### ⚙️ Generate Concept

```text
              Generate
                 │
       ┌─────────┼─────────┐
       ↓         ↓         ↓
    Logic 0   Logic 1   Logic 2
       │         │         │
       └─────────┼─────────┘
                 ↓
          Hardware Structure
```

### 🧠 Key Learning

Generate constructs are useful when multiple similar hardware structures need to be created from a parameterized or repeated RTL description.

They allow designers to describe repeated structures without manually writing the same hardware multiple times.

---

# 7️⃣ 🔹 Partial Case Assignment

The `partial_case_assign` experiment demonstrates the **hardware implications of partial assignments in case-based RTL**.

When not all possible cases are assigned, the synthesis tool may infer storage behavior depending on the RTL structure.

### ⚠️ Important

A complete combinational case structure should generally provide assignments for all required conditions.

This helps prevent unintended hardware such as latches.

### 🔄 General Flow

```text
      Case Statement
             ↓
      Check Conditions
             ↓
   Complete Assignment?
        ↙           ↘
      YES            NO
       ↓              ↓
Combinational     Possible
    Logic           Latch
```

### 🧠 Key Learning

Partial case assignments can affect the synthesized hardware.

Designers should ensure that combinational outputs receive appropriate values for every required condition.

---

# 8️⃣ ➕ Ripple Carry Adder

The **Ripple Carry Adder (RCA)** experiment demonstrates a multi-bit arithmetic structure constructed from individual **full-adder stages**.

The generated structural representation, simulation waveform, and synthesized implementation were examined.

### 🧩 Basic Structure

```text
       A0 ─────┐
       B0 ─────┤
       Cin ────┤
               ▼
             FA0
               │
               ├──── S0
               │
              C1
               │
               ▼
       A1 ───► FA1 ◄── B1
               │
               ├──── S1
               │
              C2
               │
               ▼
              FA2
               │
               ├──── S2
               │
              C3
               │
              ...
               │
               ▼
              FAn
               │
               └──── Cout
```

### ⚙️ Operation

Each full adder receives:

- 🔹 Input `A`
- 🔹 Input `B`
- 🔹 Carry input

Each full adder produces:

- 🔹 Sum
- 🔹 Carry output

The carry output of one stage becomes the carry input of the next stage.

Therefore, the carry **ripples** from one full-adder stage to the next.

### 🧠 Key Learning

The Ripple Carry Adder demonstrates how larger arithmetic circuits can be constructed by connecting smaller reusable RTL components.

---

# 🔬 RTL Simulation and Synthesis Analysis

The Day 5 experiments were analyzed at both the **RTL simulation** and **synthesis** levels.

The general flow is:

```text
             Verilog RTL
                  ↓
           RTL Simulation
                  ↓
              GTKWave
                  ↓
           Yosys Synthesis
                  ↓
        Technology Mapping
                  ↓
        Synthesized Hardware
```

This allows the RTL behavior and synthesized hardware structure to be compared.

### 🔍 Analysis

RTL simulation helps verify the intended behavior of the design before synthesis.

Yosys then processes the RTL and generates a synthesized representation.

The synthesized design can be examined to understand how the RTL constructs are converted into actual hardware structures.

---

# 🛠️ Tools Used

| **Tool / Technology** | **Purpose** |
|---|---|
| **Verilog HDL** | RTL design description |
| **Icarus Verilog** | RTL simulation |
| **GTKWave** | Waveform visualization |
| **Yosys** | RTL synthesis and optimization |
| **SKY130 Standard-Cell Library** | Technology mapping |
| **Linux** | Development environment |
| **VSDIAT Workshop Environment** | Design and synthesis environment |

---

# 🧠 Key Learning Outcomes

Through these experiments, I learned:

- 🔹 How `if` and `case` constructs are synthesized into hardware
- ⚠️ How incomplete combinational assignments can infer latches
- 🔧 How coding style affects synthesized hardware
- 🧩 How generate constructs can create repeated hardware structures
- 🔀 How MUX and DEMUX logic can be described using different RTL constructs
- 🔹 How partial case assignments affect synthesis
- ➕ How a Ripple Carry Adder can be constructed from full-adder stages
- 🔬 How to compare RTL simulation with synthesized hardware structures
- 🏭 How RTL constructs are converted into hardware during synthesis

---

# 📌 Important RTL Coding Guidelines

## 🔹 1. Combinational Logic

Use complete assignments for combinational logic:

```verilog
always @(*) begin
    // combinational logic
end
```

This ensures that the procedural block responds to changes in all relevant inputs.

---

## 🔹 2. Avoid Unintended Latches

Make sure outputs are assigned for all required conditions.

For example:

```verilog
always @(*) begin
    if (sel)
        y = a;
    else
        y = b;
end
```

This describes complete combinational behavior.

---

## 🔹 3. Use `case` Carefully

Ensure that all required input conditions are handled.

A default assignment can also be used when appropriate:

```verilog
always @(*) begin
    y = 1'b0;

    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        2'b10: y = c;
        2'b11: y = d;
    endcase
end
```

---

## 🔹 4. Generate Repeated Hardware

Use `generate` constructs when multiple similar hardware structures are required.

This makes the RTL more scalable and easier to maintain.

---

## 🔹 5. Verify RTL Before Synthesis

Simulation should be used to verify the intended behavior before analyzing the synthesized circuit.

The general verification process is:

```text
RTL
 ↓
Simulation
 ↓
Verify Functionality
 ↓
Synthesis
 ↓
Analyze Hardware
```

---

# 🔄 Overall Day 5 Flow

```text
                  RTL Constructs
                        ↓
          ┌─────────────┼─────────────┐
          ↓             ↓             ↓
         IF            CASE        GENERATE
          ↓             ↓             ↓
   Combinational     MUX/DEMUX     Repeated
      Logic           Logic        Hardware
          │             │             │
          └─────────────┼─────────────┘
                        ↓
                 RTL Simulation
                        ↓
                     GTKWave
                        ↓
                 Yosys Synthesis
                        ↓
              SKY130 Technology
                   Mapping
                        ↓
              Synthesized Hardware
```

---

# 📊 Day 5 Experiment Summary

| **Experiment** | **Main Concept** |
|---|---|
| 🔹 `bad_case` | Case-based combinational logic |
| 🔹 `comp_case` | Case-based combinational synthesis |
| 🔀 `demux_case` | DEMUX using `case` |
| ⚠️ `incomp_if` | Incomplete `if` and latch inference |
| ⚠️ `incomp_if2` | Conditional assignment and latch behavior |
| 🧩 `mux_generate` | Generate-based MUX implementation |
| 🔹 `partial_case_assign` | Partial case assignment |
| ➕ `Ripple_Carry_Adder` | Multi-bit arithmetic structure |

---

# 🎯 Main Concepts Learned

```text
       RTL Coding
            ↓
    ┌───────┼────────┐
    ↓       ↓        ↓
   IF      CASE    GENERATE
    ↓       ↓        ↓
  Logic   MUX/     Repeated
          DEMUX    Hardware
    │       │        │
    └───────┼────────┘
            ↓
       Simulation
            ↓
         GTKWave
            ↓
       Yosys Synthesis
            ↓
     Technology Mapping
            ↓
    Synthesized Hardware
```

---

# ✅ Completion Status

**Day 5 – Completed ✅**

### 📚 Main Topics

**RTL Constructs → Case/If Statements → Latch Inference → MUX/DEMUX → Generate → Ripple Carry Adder → Synthesis**

> 🚀 **Key takeaway:** Day 5 demonstrates how different RTL coding styles directly influence the hardware inferred during synthesis. Writing complete and synthesizable RTL is essential for obtaining the intended hardware implementation.
