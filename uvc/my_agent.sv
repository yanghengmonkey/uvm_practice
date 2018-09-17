`ifndef MY_AGENT__SV
`define MY_AGENT__SV

class my_agent extends uvm_agent;
    uvm_analysis_port #( my_transaction ) ap;
    my_sequencer sqr_inst;
    my_driver    drv_inst;
    my_monitor   mon_inst;

    function new(string name = "my_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction: new

    extern function void build_phase( uvm_phase phase);
    extern function void connect_phase( uvm_phase phase);
    extern function void end_of_elaboration_phase( uvm_phase phase);
    extern function void start_of_simulation_phase( uvm_phase phase);
    extern task run_phase(uvm_phase phase);
    extern function void check_phase(uvm_phase phase);
    extern function void report_phase(uvm_phase phase);
    extern function void final_phase(uvm_phase phase);

    `uvm_component_utils( my_agent )
endclass: my_agent


function void my_agent::build_phase( uvm_phase phase);
    super.build_phase(phase);
    // Create sub component
    `uvm_info(get_full_name(), "Enter build phase", UVM_HIGH);
    if( is_active == UVM_ACTIVE) begin
       sqr_inst = my_sequencer::type_id::create( "sqr_inst", this);
       drv_inst = my_driver::type_id::create( "drv_inst", this );
    end
    mon_inst = my_monitor::type_id::create( "mon_inst", this );
    ap = new("ap", this);
endfunction: build_phase

function void my_agent::connect_phase( uvm_phase phase);
    super.connect_phase(phase);
    `uvm_info(get_full_name(), "Enter connect phase", UVM_HIGH);
    if( is_active == UVM_ACTIVE) begin
        drv_inst.seq_item_port.connect(sqr_inst.seq_item_export);
    end
    mon_inst.ap.connect(ap);
endfunction: connect_phase

function void my_agent::end_of_elaboration_phase( uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    `uvm_info(get_full_name(), "Enter end_of_elaboration_phase", UVM_HIGH);
endfunction: end_of_elaboration_phase

function void my_agent::start_of_simulation_phase( uvm_phase phase);
    super.start_of_simulation_phase(phase);
    `uvm_info(get_full_name(), "start_of_simulation_phase", UVM_HIGH);
endfunction: start_of_simulation_phase

task my_agent::run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info(get_full_name(), "run_phase", UVM_HIGH);
endtask: run_phase

function void my_agent::check_phase(uvm_phase phase);
    super.check_phase(phase);
    `uvm_info(get_full_name(), "check_phase", UVM_HIGH);
endfunction: check_phase

function void my_agent::report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_full_name(), "report_phase", UVM_HIGH);
endfunction: report_phase

function void my_agent::final_phase(uvm_phase phase);
    super.final_phase(phase);
    `uvm_info(get_full_name(), "final_phase", UVM_HIGH);
endfunction: final_phase

`endif // MY_AGENT__SV
