
class virtual_sequencer extends uvm_sequencer;
    
    `uvm_component_utils(virtual_sequencer)
    
    write_sequencer seqr;
    env_config m_cfg;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction
    
    
    function void build_phase(uvm_phase phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
               `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db, have you set() it?")

        seqr = write_sequencer::type_id::create("seqr",this);
    endfunction
    
endclass

