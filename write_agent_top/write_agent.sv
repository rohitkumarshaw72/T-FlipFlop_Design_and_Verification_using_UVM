
class write_agent extends uvm_agent;

    `uvm_component_utils(write_agent)
    
    write_agent_config wr_cfg;
    write_monitor mon;
    write_sequencer seqr;
    write_driver drv;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(write_agent_config)::get(this,"","write_agent_config",wr_cfg))
            `uvm_fatal("CONFIG", "cannot get() wr_cfg from uvm_config_db, have you set() it?")
        mon = write_monitor::type_id::create("mon", this);
        
        if(wr_cfg.is_active==UVM_ACTIVE)  begin
            drv = write_driver::type_id::create("drv", this);
            seqr = write_sequencer::type_id::create("seqr", this);
        end

    endfunction
    
    function void connect_phase(uvm_phase phase);
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction
    
endclass

