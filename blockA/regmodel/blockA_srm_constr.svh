//----------------------------------------------------------------------------
// Hand edited for separting the constraints.
//----------------------------------------------------------------------------
`ifndef INCLUDED_block_a_constr_svh
`define INCLUDED_block_a_constr_svh

//------------------------------------------------------
// Node block_a 
//------------------------------------------------------
class blockA_constr extends uvm_object;
  // Constraint Class
  class t1_constr extends uvm_object; 
     `uvm_object_utils(t1_constr) 

     rand bit[31:0] field0; 
 
     function new(string name="_constr"); 
       super.new(name); 
     endfunction 

     function BlockA::t1_struct_t get_data(); 
       BlockA::t1_struct_t d; 
       d.field0 = field0; 
 
       return d;
     endfunction
  endclass

  // Constraint Class
  class r1_constr extends uvm_object; 
     `uvm_object_utils(r1_constr) 

     rand bit[32-1:0] field0; 
 
     function new(string name="r1_constr"); 
       super.new(name); 
     endfunction 

     function BlockA::r1_struct_t get_data(); 
       BlockA::r1_struct_t d; 
       d.field0 = field0;
       return d;
     endfunction
  endclass

endclass

`endif
 
