
class write_sequences extends uvm_sequence #(write_transaction);
    
    `uvm_object_utils(write_sequences)

    function new(string name = "write_sequences");
        super.new(name);
    endfunction
endclass

class write_rand_seq extends write_sequences;

    `uvm_object_utils(write_rand_seq)
    
    write_transaction tr;
    
    function new(string name = "write_rand_seq");
        super.new(name);
    endfunction
    
    task body();
        repeat (10) begin
            tr = write_transaction::type_id::create("tr");
            start_item(tr);
            assert(tr.randomize());
            finish_item(tr);
        end
    endtask
    
endclass

