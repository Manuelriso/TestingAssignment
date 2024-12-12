`timescale 1ps / 1ps

`ifndef TOPLEVEL
	`define TOPLEVEL tb_top.wrapper_i.top_i.core_i
`endif

module strobe;

integer cmp;

initial begin		
  #10;
  @(posedge `TOPLEVEL.rst_ni);
  $fs_inject;
  $display("ZOIX INJECTION");
end


always @(negedge `TOPLEVEL.clk_i) begin
  cmp = $fs_compare(`TOPLEVEL);
  if (1 == cmp) begin
    $fs_drop_status("ON", `TOPLEVEL);
  end else if (2 == cmp) begin
    $fs_drop_status("PN", `TOPLEVEL);
  end
end

endmodule
