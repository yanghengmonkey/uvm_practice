`ifndef MY_ENV__SV__
`define MY_ENV__SV__

class my_env extends uvm_env;
     my_agent agt_msr;
     my_agent agt_slv;
     my_rm    rm;// Reference model

     function new(string name = "", uvm_component parent = null);
         super.new(name, parent);
     endfunction

     function void build_phase(uvm_phase phase);
         `uvm_info(get_full_name(), "Enter build_phase", UVM_HIGH)
         super.build_phase(phase);
         agt_msr= my_agent::type_id::create("agt_msr", this);
         agt_slv= my_agent::type_id::create("agt_slv", this);
         agt_slv.is_active = UVM_PASSIVE; 
         rm = my_rm::type_id::create("rm",this);
     endfunction: build_phase

     function void connect_phase(uvm_phase phase);
         `uvm_info(get_name(), "Enter connect_phase", UVM_HIGH)
         super.connect_phase(phase);
         agt_msr.ap.connect(rm.aimp);
     endfunction: connect_phase

    `uvm_component_utils( my_env )
endclass

`endif //  MY_ENV__SV__
