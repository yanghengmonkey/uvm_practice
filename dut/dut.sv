module dut(
    clk,
    rst_n,
    rxd,
    rx_dv,
    txd,
    tx_en,
    bus_cmd_valid,
    bus_op,
    bus_addr,
    bus_wr_data,
    bus_rd_data
);

input       clk;
input       rst_n;
input [7:0] rxd;
input       rx_dv;
output[7:0] txd;
output      tx_en;

reg [7:0]   txd;
reg         tx_en;


input        bus_cmd_valid;
input        bus_op;
input[15:0]  bus_addr;
input[15:0]  bus_wr_data;
output reg[15:0] bus_rd_data;

reg [15:0] mem[15:0];

always @ (posedge clk) begin
    if ( bus_cmd_valid & bus_op ) begin
        mem[bus_addr] <= bus_wr_data;
    end
end

always @ (posedge clk) begin
    if ( bus_cmd_valid & (!bus_op) ) begin
        bus_rd_data <= mem[bus_addr];
    end
    else begin
        bus_rd_data <= 16'h0;
    end
end

always @ (posedge clk) begin
    if(!rst_n) begin
        txd   <= 'h0;
        tx_en <= 'h0;
    end
    else begin
        txd   <= rxd;
        tx_en <= rx_dv;
    end
end

endmodule
