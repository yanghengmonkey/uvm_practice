`ifndef BUS_IF__SV
`define BUS_IF__SV

interface bus_if(
input clk, 
input rst_n,
input         bus_cmd_valid,
input         bus_op,
input [15:0]  bus_addr,
input [15:0]  bus_wr_data,
input [15:0]  bus_rd_data
);

endinterface

`endif
