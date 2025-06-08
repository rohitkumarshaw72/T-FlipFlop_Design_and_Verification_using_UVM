
class scoreboard extends uvm_scoreboard;
    uvm_analysis_imp #(write_transaction, scoreboard) ap;

    `uvm_component_utils(scoreboard)

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void write(write_transaction tr);
        if (tr.t)
            `uvm_info("SCOREBOARD", $sformatf("T=1, toggling"), UVM_LOW)
        else
            `uvm_info("SCOREBOARD", $sformatf("T=0, holding"), UVM_LOW)
    endfunction
endclass

