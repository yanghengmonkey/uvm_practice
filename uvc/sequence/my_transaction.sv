`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV

class my_transaction extends uvm_sequence_item;
    function new( string name = "" );
        super.new( name );
    endfunction: new

    rand bit[47:0] dmac;
    rand bit[47:0] smac;
    rand bit[15:0] ether_type;
    rand byte      pload[];
    rand bit[31:0] crc;

    constraint pload_cons{
        pload.size >= 46;
        pload.size <= 1500;
    }

    function bit[31:0] calc_crc();
        return 32'h0;
    endfunction: calc_crc

    function void pose_randomize();
        crc = calc_crc();
    endfunction: pose_randomize

    `uvm_object_utils_begin( my_transaction )
    `uvm_object_end

endclass: my_transaction 

`endif // MY_TRANSACTION__SV
