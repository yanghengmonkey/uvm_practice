`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

import uvm_pkg::*;

class my_driver extends uvm_driver;

    `uvm_component_utils( my_driver )
    virtual my_if vif;

    function new( string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
        if( ! uvm_config_db # (virtual my_if)::get(this,"", "vif", vif) ) begin
            `uvm_fatal("NOINTF", "not get interface");
        end
    endfunction

    extern task main_phase(uvm_phase phase);
    extern function void check_phase(uvm_phase phase);

endclass: my_driver

task my_driver::main_phase(uvm_phase phase);
    phase.raise_objection(this);
    // Wait reset
    while (!vif.rst_n)begin
        @(posedge vif.clk);
    end
    // Send data
    for(int i=0; i<16; i++) begin
        @(posedge vif.clk);
        vif.data  <= i;
        vif.valid <= 1'b1;
        `uvm_info(get_full_name(),"drive interface",UVM_LOW)
    end

    phase.drop_objection(this);
endtask: main_phase

function void my_driver::check_phase(uvm_phase phase);
    //`uvm_info("my_driver", "enter check_phase", UVM_LOW);
    //print_config(1);
endfunction: check_phase
`endif // MY_DRIVER__SV
