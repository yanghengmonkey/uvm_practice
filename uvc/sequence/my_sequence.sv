`ifndef MY_SEQUENCE__SV
`define MY_SEQUENCE__SV

class my_sequence extends sequence_base #( my_transaction);
    my_transaction trans;

    function new( string name = "my_sequence" );
	    super.new(name);
	endfunction: new

    task body();
        `uvm_info(get_name(), "Enter body", UVM_LOW)
        repeat(4) begin
            `uvm_info(get_name(), "Send transaction", UVM_LOW)
            `uvm_do(trans)
        end
        `uvm_info(get_type_name(), "Exit body", UVM_LOW)
	endtask 

    `uvm_object_utils( my_sequence )
endclass : my_sequence 

`endif // MY_SEQUENCE__SV
