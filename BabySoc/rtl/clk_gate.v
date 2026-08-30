`include "sp_verilog.vh"


// Clock gate module used by SandPiper default project.

module clk_gate (output gated_clk, input free_clk, func_en, pwr_en, gating_override);

   assign gated_clk = free_clk;
endmodule
