`ifndef MY_RM__SV
`define MY_RM__SV

class my_rm extends uvm_component;
     uvm_analysis_imp  #( my_transaction, my_rm ) aimp;
     uvm_analysis_port #( my_transaction ) ap;

     function new(string name = "my_rm", uvm_component parent = null );
        super.new(name,parent);
     endfunction: new

     function void build_phase(uvm_phase phase );
         super.build_phase( phase );
         aimp = new("aimp", this);
         ap   = new("ap", this);
     endfunction: build_phase

     function void write( my_transaction tr );
         my_transaction new_tr;
         `uvm_info(get_name(), "Enter aimp write", UVM_HIGH)
         new_tr = new("new_tr");
         new_tr.copy(tr);
         ap.write(new_tr);
     endfunction: write

    `uvm_component_utils( my_rm )
endclass: my_rm

`endif // MY_RM__SV
