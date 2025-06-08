
class write_transaction extends uvm_sequence_item;
    rand bit t;
    bit resetn, q;

    `uvm_object_utils(write_transaction)

    function new(string name = "write_transaction");
        super.new(name);
    endfunction
    
    function void do_print(uvm_printer printer);
        super.do_print(printer);
        
        //string name                  bitstream value        size      radix_for_printing
        printer.print_field("t",  this.t,           1,        UVM_HEX);
        printer.print_field("q",  this.q,           1,        UVM_HEX);
        
    endfunction
    
endclass

