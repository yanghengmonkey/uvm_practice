`ifndef REG_MODEL__SV
`define REG_MODEL__SV

class reg_invert extends uvm_reg;
    rand uvm_reg_field reg_data;

    function new( string name = "reg_invert" );
        super.new( name, 16, UVM_NO_COVERAGE );
    endfunction: new

    virtual function void build();
        reg_data = uvm_reg_field::type_id::create( "reg_data" );
        reg_data.configure( this, 1, 0, "RW", 1, 0, 1, 1, 0 );
    endfunction: build

     `uvm_object_utils( reg_invert )
endclass: reg_invert

class reg_model extends uvm_reg_block;
    rand reg_invert invert;

    function new ( string name = "reg_model" );
        super.new( name, UVM_NO_COVERAGE );
    endfunction: new

    virtual function void build();
        default_map = create_map( "default_map", 0, 2, UVM_BIG_ENDIAN, 0 );
        invert = reg_invert::type_id::create( "invert" );
        invert.configure( this, null, "" );
        invert.build();
        default_map.add_reg(invert, 'h0, "RW");
    endfunction: build

    `uvm_object_utils( reg_model )
endclass: reg_model 

`endif // REG_MODEL__SV