`ifndef MY_SEQUENCER__SV
`define MY_SEQUENCER__SV
class my_sequencer extends uvm_sequencer #( my_transaction );

    function new( string name = "my_sequencer", uvm_component parent = null );
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_full_name(), "Enter build phase", UVM_HIGH)
        super.build_phase(phase);
    endfunction : build_phase

    `uvm_component_utils( my_sequencer )
endclass: my_sequencer 

`endif // MY_SEQUENCER__SV
