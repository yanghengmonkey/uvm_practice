`ifndef MY_SCB__SV
`define MY_SCB__SV

class my_scb extends uvm_scoreboard;
    uvm_analysis_export # ( my_transaction  ) pdr_exp;
    uvm_analysis_export # ( my_transaction  ) mtr_exp;
    uvm_tlm_analysis_fifo #( my_transaction ) pdr_fifo, mtr_fifo;

    function new(string name = "my_scb", uvm_component parent = null );
        super.new(name, parent);
    endfunction: new

    function void build_phase( uvm_phase phase );
        super.build_phase( phase );
        pdr_exp  = new("pdr_exp",  this);
        mtr_exp  = new("mtr_exp",  this);
        pdr_fifo = new("pdr_fifo", this);
        mtr_fifo = new("mtr_fifo", this);
    endfunction: build_phase

    function void connect_phase( uvm_phase phase );
        super.connect_phase( phase );
        pdr_exp.connect( pdr_fifo.analysis_export );
        mtr_exp.connect( mtr_fifo.analysis_export );
    endfunction: connect_phase

    task run_phase( uvm_phase phase );
        bit match = 0;
        my_transaction pdr_tr, mtr_tr;
        `uvm_info( get_name(), "Enter run_phase", UVM_HIGH)
        super.run_phase( phase );
        forever begin
            mtr_fifo.get(mtr_tr);
            pdr_fifo.get(pdr_tr);
            `uvm_info( get_name(), "get transaction from mtr_fifo/pdr_fifo", UVM_HIGH)
            match = mtr_tr.compare(pdr_tr);
            if ( !match ) begin
                `uvm_error(get_name(), "Not match")
                `uvm_info(get_name(), "Monitor", UVM_LOW)
                 mtr_tr.print();
                `uvm_info(get_name(), "Predictor", UVM_LOW)
                 pdr_tr.print();
            end
        end
    endtask: run_phase

    `uvm_component_utils( my_scb )
endclass: my_scb

`endif // MY_SCB__SV
