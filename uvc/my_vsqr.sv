`ifndef MY_VSQR__SV
`define MY_VSQR__SV

class my_vsqr extends uvm_sequencer #( my_transaction );
     my_sequencer my_sqr;
     bus_sequencer bus_sqr;

     function new ( string name = "", uvm_component parent = null );
         super.new(name, parent);
     endfunction: new
     
    `uvm_component_utils( my_vsqr )
endclass: my_vsqr

`endif // MY_VSQR__SV
