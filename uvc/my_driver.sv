`ifndef MY_DRIVER__SV
`define MY_DRIVER__SV

class my_driver extends uvm_driver #( my_transaction );
    // Variable defination
    virtual my_if vif;

    function new( string name = "my_driver", uvm_component parent = null);
        super.new(name, parent);
        if( ! uvm_config_db # (virtual my_if)::get(this,"", "vif", vif) ) begin
            `uvm_fatal("NOINTF", "not get interface");
        end
    endfunction

    extern function void build_phase(uvm_phase phase);
    extern task pre_reset_phase(uvm_phase phase);
    extern task reset_phase(uvm_phase phase);
    extern task post_reset_phase(uvm_phase phase);
    extern task pre_configure_phase(uvm_phase phase);
    extern task configure_phase(uvm_phase phase);
    extern task post_configure_phase(uvm_phase phase);
    extern task pre_main_phase(uvm_phase phase);
    extern task main_phase(uvm_phase phase);
    extern task post_main_phase(uvm_phase phase);
    extern task pre_shutdown_phase(uvm_phase phase);
    extern task shutdown_phase(uvm_phase phase);
    extern task post_shutdown_phase(uvm_phase phase);
    extern function void check_phase(uvm_phase phase);
    extern task drive_one_pkt(my_transaction tr);

    `uvm_component_utils( my_driver )
endclass: my_driver

function void my_driver::build_phase(uvm_phase phase);
    `uvm_info(get_name(),"Enter build phase",UVM_HIGH)
endfunction: build_phase

task my_driver::main_phase(uvm_phase phase);
    `uvm_info(get_name(),"Enter main_phase",UVM_HIGH)
    vif.valid <= 0;
    vif.data  <= 0;
    while(!vif.rst_n) begin
        @(posedge vif.clk);
    end

    while(1) begin
        seq_item_port.get_next_item(req);
        drive_one_pkt(req);
        seq_item_port.item_done();
    end
    `uvm_info(get_name(),"Exit main_phase",UVM_HIGH)
endtask: main_phase

function void my_driver::check_phase(uvm_phase phase);
    `uvm_info("my_driver", "enter check_phase", UVM_LOW);
    //print_config(1);
endfunction: check_phase

task my_driver::drive_one_pkt(my_transaction tr);
    byte unsigned data_q[];
    int data_size;

    `uvm_info(get_name(), "Start drive one pkt", UVM_HIGH)
    data_size = tr.pack_bytes(data_q)/8;

    @(posedge vif.clk);
    for (int i=0; i<data_size; i++) begin
        @(posedge vif.clk);
        vif.data  <= data_q[i];
        vif.valid <= 1'b1;
    end
    @(posedge vif.clk);
    vif.valid <= 1'b0;
    `uvm_info(get_name(), "End drive one pkt", UVM_HIGH)

endtask: drive_one_pkt


task my_driver::pre_reset_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter pre_reset_phase", UVM_HIGH)
endtask
task my_driver::reset_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter reset_phase", UVM_HIGH)
endtask
task my_driver::post_reset_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter post_reset_phase", UVM_HIGH)
endtask
task my_driver::pre_configure_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter pre_configure_phase", UVM_HIGH)
endtask
task my_driver::configure_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter configure_phase", UVM_HIGH)
endtask
task my_driver::post_configure_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter post_configure_phase", UVM_HIGH)
endtask
task my_driver::pre_main_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter pre_main_phase", UVM_HIGH)
endtask
task my_driver::post_main_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter post_main_phase", UVM_HIGH)
endtask
task my_driver::pre_shutdown_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter pre_shutdown_phase", UVM_HIGH)
endtask
task my_driver::shutdown_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter shutdown_phase", UVM_HIGH)
endtask
task my_driver::post_shutdown_phase(uvm_phase phase);
    `uvm_info(get_name(), "Enter post_shutdown_phase", UVM_HIGH)
endtask
`endif // MY_DRIVER__SV
