module tb_top;

reg clk;
reg rst_n;

`ifndef DUT_MOD
`define DUT_MOD dut
`endif

initial begin
    force `DUT_MOD.clk   = clk;
    force `DUT_MOD.rst_n = rst_n;
end
// fsdb dump
DUMPCTRL dumpctrl( .CLK(clk) );

initial begin
    run_test();
end
// Clock
initial begin
    clk = 0;
    forever #10 clk = ~clk;
end
// Reset
initial begin
    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;
end

endmodule
