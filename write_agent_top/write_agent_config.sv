
class write_agent_config extends uvm_object;
    
    `uvm_object_utils(write_agent_config)

    virtual tff_if vif;
    
    uvm_active_passive_enum is_active = UVM_ACTIVE;

    function new(string name = "write_agent_config");
        super.new(name);
    endfunction
endclass

