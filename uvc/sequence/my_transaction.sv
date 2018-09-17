`ifndef MY_TRANSACTION__SV
`define MY_TRANSACTION__SV

class my_transaction extends uvm_sequence_item;

    rand bit[47:0] dmac;
    rand bit[47:0] smac;
    rand bit[15:0] ether_type;
    rand byte      pload[];
    rand bit[31:0] crc;

    constraint pload_cons{
        pload.size >= 4;
        pload.size <= 5;
    }

    function bit[31:0] calc_crc();
        return 32'h0;
    endfunction: calc_crc

    function void pose_randomize();
        crc = calc_crc();
    endfunction: pose_randomize

    `uvm_object_utils_begin( my_transaction )
        `uvm_field_int( dmac, UVM_ALL_ON )
        `uvm_field_int( smac, UVM_ALL_ON )
        `uvm_field_int( ether_type, UVM_ALL_ON )
        `uvm_field_array_int( pload, UVM_ALL_ON )
        `uvm_field_int( crc, UVM_ALL_ON )
    `uvm_object_utils_end

    function new( string name = "my_transaction" );
        super.new( name );
    endfunction: new

endclass: my_transaction 

`endif // MY_TRANSACTION__SV
