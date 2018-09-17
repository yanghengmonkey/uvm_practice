module tb_top;

reg clk;
reg rst_n;
// Interface
my_if input_if(
    .clk   ( clk   ),
    .rst_n ( rst_n )
);
my_if output_if(
    .clk   ( clk   ),
    .rst_n ( rst_n )
);
// DUT
dut dut_inst(
    .clk   ( clk             ),
    .rst_n ( rst_n           ),
    .rxd   ( input_if.data   ),
    .rx_dv ( input_if.valid  ),
    .txd   ( output_if.data  ),
    .tx_en ( output_if.valid )
);
// fsdb dump
DUMPCTRL dumpctrl( .CLK(clk) );

// Driver
initial begin
    uvm_config_db#(virtual my_if)::set(null, "*agt_msr.drv_inst*", "vif", input_if);
    uvm_config_db#(virtual my_if)::set(null, "*agt_msr.mon_inst*", "vif", input_if);
    uvm_config_db#(virtual my_if)::set(null, "*agt_slv.mon_inst*", "vif", output_if);
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
