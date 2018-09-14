`ifndef MY_AGENT__SV
`define MY_AGENT__SV
class my_agent extends uvm_agent;
    `uvm_component_utils( my_agent )
    my_driver drv_inst;

    function new(string name = "my_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    extern function void build_phase( uvm_phase phase);
    extern function void connect_phase( uvm_phase phase);

endclass: my_agent


function void my_agent::build_phase( uvm_phase phase);
    super.build_phase(phase);
    // Create sub component
    `uvm_info(get_full_name(), "Enter build phase", UVM_LOW);
    drv_inst = my_driver::type_id::create( "drv_inst", this );
endfunction: build_phase

function void my_agent::connect_phase( uvm_phase phase);
    super.connect_phase(phase);
endfunction: connect_phase

`endif // MY_AGENT__SV
