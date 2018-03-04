//----------------------------------------------------------------------------
// Hand edited for separting the constraints.
//----------------------------------------------------------------------------
`ifndef INCLUDED_block_a_svh
`define INCLUDED_block_a_svh

//------------------------------------------------------
// Node block_a 
//------------------------------------------------------
class BlockA extends srm_node;
 
  //------------------------------------------------------
  // Table t1 
  //------------------------------------------------------
  typedef struct packed {
    reg[31:0] field0;
  } t1_struct_t; 

  class T1 extends srm_table#(t1_struct_t);

    // Entry in the table
    class t1_entry extends srm_table_entry#(t1_struct_t);
      srm_field#(bit[31:0]) field0;

      function new(string name, srm_node parent, srm_addr_t index=-1);
        super.new(name, parent, index);
        set_reset_kind("hard_reset"); 
        field0 = new(.name("field0"), .parent(this), .n_bits(32), .lsb_pos(0), .volatile(0)); 
        add_field(field0);
        field0.set_reset_value(.kind("hard_reset"), .value(32'h0)); 
      endfunction

      virtual function t1_entry clone(srm_addr_t index);
        t1_entry obj;
        obj = new(.name($psprintf("%s_%0d", get_name(), index)),
                .parent(_parent), .index(index));
        __initialize(obj);
        return obj;
       endfunction
    endclass

    // Create the table t1 
    function new(string name, srm_node parent);
      t1_entry entry;
      super.new(name, parent, .num_entries(1024));
      entry = new(.name("t1_entry"), .parent(this));
      _prototype = entry;
    endfunction

    // Covrariant return type: LRM 2012 Feature
    virtual function t1_entry entry_at(srm_addr_t index);
      t1_entry obj;
      srm_table_entry#(t1_struct_t) entry;
      entry = super.entry_at(index);
      $cast(obj, entry);
      return obj;
    endfunction

  endclass
 
  //------------------------------------------------------
  // Register R1 
  //------------------------------------------------------
  typedef struct packed {
    reg[31:0] field0;
  } r1_struct_t; 

  class R1 extends srm_reg#(r1_struct_t);
        srm_field#(bit[32-1:0]) field0;
    
    function new(string name, srm_node parent);
      super.new(name, parent);
      set_reset_kind("hard_reset"); 
      field0 = new(.name("field0"), .parent(this), .n_bits(32), .lsb_pos(0), .volatile(0)); 
      add_field(field0);
      field0.set_reset_value(.kind("hard_reset"), .value(32'h0)); 
    endfunction

  endclass
  // Instantiate the children
  T1  t1;
  R1  r1;

  function new(string name, srm_node parent);
    super.new(name, parent);
    t1 = new(.name("t1"), .parent(this));
    add_child(t1);
    t1.set_offset("default", .offset('h0));
    r1 = new(.name("r1"), .parent(this));
    add_child(r1);
    r1.set_offset("default", .offset('h0));
  endfunction

endclass

`endif
