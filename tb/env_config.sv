
class env_config extends uvm_object;
    
    bit has_wagent = 1;
    bit has_scoreboard;
    bit has_virtual_sequencer = 1;
    
    `uvm_object_utils(env_config)
    
    write_agent_config wr_cfg;

    function new(string name = "env_config");
        super.new(name);
    endfunction
endclass

