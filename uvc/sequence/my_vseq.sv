`ifndef MY_VSEQ__SV
`define MY_VSEQ__SV

class my_vseq extends sequence_base # ( my_transaction );
     `uvm_declare_p_sequencer( my_vsqr )
     my_sequence my_seq;
     bus_sequence bus_seq;

     function new(string name = "my_vseq" );
         super.new(name);
     endfunction
     
     task body();
         fork
             `uvm_do_on( my_seq, p_sequencer.my_sqr )
             `uvm_do_on( bus_seq, p_sequencer.bus_sqr )
         join
     endtask

    `uvm_object_utils( my_vseq )
endclass: my_vseq 

`endif // MY_VSEQ__SV
