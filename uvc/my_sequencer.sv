`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV
class my_sequencer extends uvm_sequencer #( my_transaction );
    `uvm_component_utils( my_sequencer )

    function new( string name = "my_sequencer", uvm_component parent = null );
        super.new(name, parent);
    endfunction: new

endclass: my_sequencer 
`endif // MY_SEQUENCER__SV
