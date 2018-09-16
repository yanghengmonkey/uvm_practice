`ifndef DUMPCTRL__SV
`define DUMPCTRL__SV
module DUMPCTRL(
    input CLK
);

string dump_file;
string dump_scope;
bit    dump_enable;
int    cycles;

initial begin
    dump_file   = "verilog.fsdb";
    dump_scope  = "dump_scope.def";
    dump_enable = 1; 
    cycles      = 0;
end

initial begin
    if($value$plusargs("DUMP=%d", dump_enable)) begin
        $display("ENV DUMP=%d", dump_enable);
    end
    if( dump_enable ) begin
        $fsdbDumpvarsToFile( dump_scope, dump_file);
        $fsdbDumpon;
    end
end

endmodule

`endif // DUMPCTRL__SV
