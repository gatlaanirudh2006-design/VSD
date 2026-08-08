Day 1 – Verilog RTL Design, Simulation and Synthesis

Day 1 focused on learning the basics of Verilog RTL design, simulation, testbench creation, waveform analysis, and RTL synthesis.

What I Learned
Understood the difference between a Design, Testbench, and Simulator.
Learned the basic workflow of RTL design and verification.
Used Icarus Verilog for compiling and simulating Verilog code.
Used GTKWave to observe simulation waveforms.
Implemented a 2-to-1 Multiplexer using Verilog.
Verified the multiplexer using a testbench.
Explored Yosys for RTL synthesis and viewed the synthesized hardware representation.
2-to-1 Multiplexer

The multiplexer has two inputs, one select signal, and one output.

Select	Output
0	i0
1	i1
Verilog Code
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
Simulation Commands

Install the required tools:

sudo apt install iverilog
sudo apt install gtkwave

Compile the design and testbench:

iverilog good_mux.v tb_good_mux.v

Run the simulation:

./a.out

View the generated waveform:

gtkwave tb_good_mux.vcd
Simulation Flow
Design + Testbench
        ↓
   Icarus Verilog
        ↓
     VCD File
        ↓
      GTKWave
        ↓
 Waveform Analysis
Yosys Synthesis

After simulation, the RTL design was explored using Yosys to understand how Verilog code is converted into a synthesized hardware representation.

The synthesized multiplexer contains:

A0 → i0
A1 → i1
S → sel
X → y
Day 1 Outcome

Successfully implemented and verified a 2-to-1 Multiplexer using Verilog HDL, performed simulation using Icarus Verilog, analyzed the waveform using GTKWave, and explored RTL synthesis using Yosys.
