`ifndef MY_ENV__SV__
`define MY_ENV__SV__

class my_env extends uvm_env;
     my_agent agt_msr;
     my_agent agt_slv;
     bus_agent agt_bus;
     my_rm    rm;// Reference model
     my_scb   scb;// Scoreboard
     my_vsqr  vsqr;// Vritual sequencer
     reg_model p_rm;// Reg model
     my_adapter adapter;

     function new(string name = "", uvm_component parent = null);
         super.new(name, parent);
     endfunction

     function void build_phase(uvm_phase phase);
         `uvm_info(get_full_name(), "Enter build_phase", UVM_HIGH)
         super.build_phase(phase);
         agt_msr= my_agent::type_id::create("agt_msr", this);
         agt_slv= my_agent::type_id::create("agt_slv", this);
         agt_slv.is_active = UVM_PASSIVE; 
         agt_bus= bus_agent::type_id::create("agt_bus", this);
         rm  = my_rm::type_id::create("rm",this);
         scb = my_scb::type_id::create("scb", this);
         vsqr = my_vsqr::type_id::create("vsqr", this);
         p_rm =reg_model::type_id::create("p_rm");// Reg model
         p_rm.configure(null,"");
         p_rm.build();
         p_rm.lock_model();
         p_rm.reset();
         adapter = my_adapter::type_id::create("adapter");
     endfunction: build_phase

     function void connect_phase(uvm_phase phase);
         `uvm_info(get_name(), "Enter connect_phase", UVM_HIGH)
         super.connect_phase(phase);
         agt_msr.ap.connect(rm.aimp);
         rm.ap.connect(scb.pdr_exp);
         agt_slv.ap.connect(scb.mtr_exp);
         vsqr.my_sqr = agt_msr.sqr_inst;
         vsqr.bus_sqr = agt_bus.sqr;
         p_rm.default_map.set_sequencer(vsqr.bus_sqr, adapter);
         p_rm.default_map.set_auto_predict(1);
     endfunction: connect_phase

    `uvm_component_utils( my_env )
endclass

`endif //  MY_ENV__SV__
