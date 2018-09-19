`ifndef MY_TEST__SV
`define MY_TEST__SV

class my_test extends uvm_test;
    my_env env_inst;

    function new(string name = "uvm_test", uvm_component parent = null);
       super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
       `uvm_info(get_full_name(), "Enter build_phase", UVM_HIGH)
        super.build_phase(phase);
        env_inst = my_env::type_id::create("env_inst", this);
/*
        uvm_config_db #(uvm_object_wrapper) :: set (
                                                    this,
                                                    "env_inst.agt_inst.sqr_inst.main_phase",
                                                    "default_sequence",
                                                    my_sequence::type_id::get()
                                                   );
*/
    endfunction

    task main_phase(uvm_phase phase);
        uvm_status_e   status;
        uvm_reg_data_t data;
        uvm_reg_addr_t addrs[];

        my_vseq seq = new();
        super.main_phase(phase);
        phase.raise_objection(this);
        phase.phase_done.set_drain_time(this, 100);

        seq.set_starting_phase(phase);
        seq.start(env_inst.vsqr);

        env_inst.p_rm.invert.write(status, 1, UVM_FRONTDOOR);
        env_inst.p_rm.invert.read(status, data, UVM_FRONTDOOR);

        phase.drop_objection(this);
    endtask: main_phase

    `uvm_component_utils( my_test )
endclass: my_test 

`endif // MY_TEST__SV
