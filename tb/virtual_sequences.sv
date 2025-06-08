
class virtual_sequences extends uvm_sequence;
    `uvm_object_utils(virtual_sequences)

    function new(string name = "virtual_sequences");
        super.new(name);
    endfunction

    task body();
        write_sequences seq = write_sequences::type_id::create("seq");
        seq.start(null);
    endtask
endclass

