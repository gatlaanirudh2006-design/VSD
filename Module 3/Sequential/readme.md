# 🔄 Module 3 – Sequential Optimizations

This section demonstrates **sequential logic optimization** using **Yosys** and focuses on how synthesis tools simplify sequential RTL containing constants, reset conditions, and flip-flop dependencies.

---

## 🎯 Objective

The objective is to understand how **Yosys optimizes sequential RTL** and identifies opportunities for:

* 🔹 Constant propagation
* 🔹 Redundant logic removal
* 🔹 Reset logic simplification
* 🔹 Flip-flop optimization
* 🔹 Sequential dependency analysis

### 📂 Examples Used

The examples covered are:

* `dff_const1`
* `dff_const2`
* `dff_const3`
* `dff_const4`
* `dff_const5`

> ℹ️ **Note:** The RTL designs demonstrate how constants, reset conditions, and flip-flop dependencies can allow synthesis tools to simplify sequential logic.

---

# 📁 Directory Structure

```text
Module_3/
└── Sequential/
    ├── dff_const1/
    │   └── dff_const1.v
    ├── dff_const2/
    │   └── dff_const2.v
    ├── dff_const3/
    │   └── dff_const3.v
    ├── dff_const4/
    │   └── dff_const4.v
    └── dff_const5/
        └── dff_const5.v
```

---

# 1️⃣ `dff_const1`

## 🧩 RTL Concept

The flip-flop output is assigned a constant value after reset.

```verilog
module dff_const1(input clk, input reset, output reg q);

always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b0;
    else
        q <= 1'b1;
end

endmodule
```

### ⚙️ Optimization

The output eventually becomes a constant `1` after the active clock operation.

Yosys can identify constant behavior and simplify the resulting logic where possible.

---

# 2️⃣ `dff_const2`

## 🧩 RTL Concept

The flip-flop is assigned the same constant value in both reset and normal operation.

```verilog
module dff_const2(input clk, input reset, output reg q);

always @(posedge clk, posedge reset)
begin
    if(reset)
        q <= 1'b1;
    else
        q <= 1'b1;
end

endmodule
```

### ⚙️ Optimization

Since `q` is always assigned `1`, the sequential element is redundant from a functional perspective and can be optimized to a constant.

---

# 3️⃣ `dff_const3`

## 🧩 RTL Concept

The design uses a reset input and constant assignments that allow Yosys to simplify the sequential logic.

### 🔍 Synthesis Observation

The synthesized result demonstrates:

* 🔹 Constant propagation
* 🔹 Removal of unnecessary sequential logic
* 🔹 Simplification of the resulting hardware

---

# 4️⃣ `dff_const4`

## 🧩 RTL Code

```verilog
module dff_const4(input clk, input reset, output reg q);
    reg q1;

    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            q  <= 1'b1;
            q1 <= 1'b1;
        end
        else
        begin
            q1 <= 1'b1;
            q  <= q1;
        end
    end

endmodule
```

### ⚙️ Optimization

Both `q1` and `q` are driven toward the constant value `1`.

Yosys can propagate the constant through the sequential logic and remove redundant logic when the behavior allows it.

---

# 5️⃣ `dff_const5`

## 🧩 RTL Code

```verilog
module dff_const5(input clk, input reset, output reg q);
    reg q1;

    always @(posedge clk, posedge reset)
    begin
        if(reset)
        begin
            q  <= 1'b0;
            q1 <= 1'b0;
        end
        else
        begin
            q1 <= 1'b1;
            q  <= q1;
        end
    end

endmodule
```

### ⚙️ Optimization

Unlike a simple constant-output flip-flop, this design contains a dependency between `q1` and `q`.

After reset:

1. 🔹 `q` and `q1` are `0`.
2. 🔹 On the next clock edge, `q1` becomes `1`.
3. 🔹 `q` receives the previous value of `q1`.
4. 🔹 On the following clock edge, `q` becomes `1`.

Therefore, the sequential behavior must be considered before removing the flip-flops.

---

# 🛠️ Yosys Synthesis

The designs can be synthesized using **Yosys**.

> 📌 **Note:** The commands below are provided for documentation and reproduction. Simulation and GTKWave are not required for the primary synthesis flow.

---

## 1️⃣ Step 1 – Open the Terminal

Go to the required design directory.

For `dff_const4`:

```bash
cd ~/VSDIAT/Module_3/Sequential/dff_const4
```

Or for `dff_const5`:

```bash
cd ~/VSDIAT/Module_3/Sequential/dff_const5
```

---

## 2️⃣ Step 2 – Start Yosys

```bash
yosys
```

---

## 3️⃣ Step 3 – Read the Verilog RTL

For `dff_const4`:

```text
read_verilog dff_const4.v
```

For `dff_const5`:

```text
read_verilog dff_const5.v
```

---

## 4️⃣ Step 4 – Set the Top Module

For `dff_const4`:

```text
synth -top dff_const4
```

For `dff_const5`:

```text
synth -top dff_const5
```

---

## 5️⃣ Step 5 – Run Optimization

```text
opt_clean
```

### 🔧 Complete Synthesis Flow

A typical flow can include:

```text
read_verilog dff_const3.v
synth -top dff_const3
opt_clean
stat
show
```

For technology mapping, the SKY130 Liberty file can also be used with ABC:

```text
abc -liberty <path-to-sky130-liberty-file>
```

> 💡 Replace `<path-to-sky130-liberty-file>` with the actual SKY130 Liberty file available in your environment.

---

## 6️⃣ Step 6 – View Statistics

Use:

```text
stat
```

The statistics can be used to observe:

* 📊 Number of wires
* 📊 Number of processes
* 📊 Number of cells
* 📊 Number of flip-flops
* 📊 Changes after optimization

This helps compare the original and optimized designs.

---

# 👀 Viewing the Synthesized Design

To generate a graphical representation of the synthesized circuit:

```text
show
```

Yosys uses **Graphviz** to display the synthesized design.

This allows the optimized circuit to be compared with the original RTL structure.

---

# 🌊 Optional GTKWave Flow

GTKWave is only required if a **testbench and waveform dump** are available.

For example:

```bash
gtkwave dump.vcd
```

The waveform can be used to verify the sequential behavior of the design.

> ℹ️ **For this repository documentation, GTKWave is optional. The RTL and synthesis results are the primary focus.**

---

# 🧠 Key Learning

Sequential optimization demonstrates that synthesis tools do more than simply convert RTL into gates.

Yosys can:

* 🔹 Propagate constant values
* 🔹 Remove redundant logic
* 🔹 Simplify reset logic
* 🔹 Remove unused registers
* 🔹 Optimize flip-flop logic
* 🔹 Preserve required sequential dependencies
* 🔹 Map optimized RTL to technology-specific cells

The `dff_const` examples show how apparently different RTL descriptions can result in significantly simplified synthesized hardware.

---

# 🛠️ Tools Used

| Tool               | Purpose                           |
| ------------------ | --------------------------------- |
| **Verilog HDL**    | RTL description                   |
| **Yosys**          | RTL synthesis and optimization    |
| **Graphviz**       | Synthesized circuit visualization |
| **GTKWave**        | Optional waveform visualization   |
| **SKY130 Library** | Technology mapping                |

---

# 📌 Module

**Module 3 – Combinational and Sequential Optimizations**

### 📚 Topic

**Sequential Optimization – Constant Propagation and Flip-Flop Optimization**

---

# ✅ Conclusion

The sequential optimization examples demonstrate how **Yosys analyzes sequential RTL and simplifies hardware based on constant values, reset conditions, and register dependencies**.

The `dff_const1` to `dff_const5` examples show different forms of sequential behavior and demonstrate why synthesis tools must consider both **logic values and clock-to-clock dependencies**.

Overall, this exercise provides a practical understanding of:

**RTL → Sequential Optimization → Constant Propagation → Redundant Logic Removal → Synthesis → Technology Mapping**

