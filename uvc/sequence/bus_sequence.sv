`ifndef BUS_SEQUENCE__SV
`define BUS_SEQUENCE__SV

class bus_sequence extends sequence_base #( bus_transaction );

     function new( string name = "");
         super.new( name );
     endfunction: new

     task body();
     endtask

    `uvm_object_utils( bus_sequence )
endclass

`endif // BUS_SEQUENCE__SV
