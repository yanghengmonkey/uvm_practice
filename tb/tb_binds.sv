`ifndef TB_BINDS__SV
`define TB_BINDS__SV

`ifndef RTL_MOD
`define RTL_MOD dut
`endif

// Interface
bind  `RTL_MOD my_if input_if(
    .clk   ( clk   ),
    .rst_n ( rst_n ),
    .data  ( rxd   ),
    .valid ( rx_dv )
);
bind `RTL_MOD my_if output_if(
    .clk   ( clk   ),
    .rst_n ( rst_n ),
    .data  ( txd   ),
    .valid ( tx_en )
);

bind `RTL_MOD bus_if reg_if(
    .clk   ( clk   ),
    .rst_n ( rst_n ),
    .bus_cmd_valid( bus_cmd_valid ),
    .bus_op       ( bus_op        ),
    .bus_addr     ( bus_addr      ),
    .bus_wr_data  ( bus_wr_data   ),
    .bus_rd_data  ( bus_rd_data   )
);

module bind_intf_input_if;
    initial begin
        uvm_config_db#(virtual my_if)::set(null, "*agt_msr.drv_inst*", "vif", `RTL_MOD.input_if);
        uvm_config_db#(virtual my_if)::set(null, "*agt_msr.mon_inst*", "vif", `RTL_MOD.input_if);
        uvm_config_db#(virtual my_if)::set(null, "*agt_slv.mon_inst*", "vif", `RTL_MOD.output_if);
        uvm_config_db#(virtual bus_if)::set(null, "*agt_bus.drv*", "vif", `RTL_MOD.reg_if);
        uvm_config_db#(virtual bus_if)::set(null, "*agt_bus.mon*", "vif", `RTL_MOD.reg_if);
    end
endmodule: bind_intf_input_if

bind `RTL_MOD bind_intf_input_if bind_intf_input_if_inst();

`endif // TB_BINDS__SV
