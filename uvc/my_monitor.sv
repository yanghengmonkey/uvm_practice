`ifndef MY_MONITOR__SV
`define MY_MONITOR__SV

class my_monitor extends uvm_monitor;
    uvm_analysis_port #(my_transaction) ap;
    virtual my_if vif;
    my_transaction tr;
    

    function new( string name = "my_monitor", uvm_component parent = null );
        super.new(name, parent);
    endfunction: new

    function void build_phase(uvm_phase phase);
        `uvm_info(get_name(), "Enter build_phase", UVM_HIGH)
        super.build_phase(phase);
        ap = new("ap", this);
        if(! uvm_config_db #(virtual my_if) :: get(this, "", "vif", vif) ) begin
            `uvm_fatal(get_name(), "Didn't get interface")
        end
    endfunction: build_phase

    task run_phase( uvm_phase phase );
        `uvm_info(get_name(), "Enter run_phase", UVM_HIGH)
        forever begin
            tr = new("tr");
            collect_one_pkt(tr);
            ap.write(tr);
        end
    endtask: run_phase

    task collect_one_pkt(my_transaction tr);
        byte unsigned data_q[$];
        byte unsigned data_array[];
        logic [7:0]   data;
        logic         valid = 0;
        int           data_size;

        while(1) begin
            @(posedge vif.clk);
            if(vif.valid) break;
        end

        while(vif.valid) begin
            data_q.push_back( vif.data );
            @(posedge vif.clk);
        end

        data_size = data_q.size();
        data_array = new[data_size];

        for(int i=0; i<data_size; i++) begin
            data_array[i] = data_q[i];
        end

        tr.pload = new[data_size - 18];
        data_size = tr.unpack_bytes(data_array) /8;
        `uvm_info(get_name(), "End of collect one pkt", UVM_HIGH)

    endtask: collect_one_pkt
    `uvm_component_utils( my_monitor )
endclass: my_monitor 

`endif // MY_MONITOR__SV
