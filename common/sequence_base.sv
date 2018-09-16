`ifndef SEQUENCE_BASE__SV
`define SEQUENCE_BASE__SV

class sequence_base #(type REQ = uvm_sequence_item, type RSP = REQ ) extends uvm_sequence #(REQ, RSP);
    // Define variables
    uvm_phase phase;

    function new(string name = "sequence_base");
        super.new(name);
    endfunction

    virtual task pre_start();
        super.pre_start();
        `uvm_info(get_type_name(), "Enter pre_start", UVM_HIGH)
        if( get_starting_phase() != null ) begin
            phase = get_starting_phase();
            `uvm_info(get_type_name(), "Raise objection", UVM_HIGH)
            phase.raise_objection(this);
        end
    endtask: pre_start

    virtual task post_start();
        super.post_start();
        `uvm_info(get_type_name(), "Enter post_start", UVM_HIGH)
        if( get_starting_phase() != null ) begin
            phase = get_starting_phase();
            `uvm_info(get_type_name(), "Drop objection", UVM_HIGH)
            phase.drop_objection(this);
        end
    endtask: post_start

    `uvm_object_utils( sequence_base )
endclass: sequence_base 

`endif // SEQUENCE_BASE__SV
