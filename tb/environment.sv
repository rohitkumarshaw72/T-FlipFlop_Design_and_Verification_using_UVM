
class environment extends uvm_env;
    
    `uvm_component_utils(environment)

    write_agent_top wr_agt_top;
    virtual_sequencer v_seqr;
    scoreboard scb;
    env_config m_cfg;
    
    function new(string name="environment", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
            `uvm_fatal("CONFIG","cannot get() m_cfg from uvm_config_db, have you set() it?")
    
        begin
            wr_agt_top = write_agent_top::type_id::create("wr_agt_top",this);
        end
        
        if(m_cfg.has_virtual_sequencer)  begin
            v_seqr = virtual_sequencer::type_id::create("v_seqr",this);
        end
        
        if(m_cfg.has_scoreboard)  begin
            scb = scoreboard::type_id::create("scb",this);
        end
    
    endfunction
    

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        v_seqr.seqr = wr_agt_top.wr_agent.seqr;
        `uvm_info("ENVIRONMENT","This is connect phase of environment", UVM_LOW)
    endfunction

    
    function void end_of_elaboration_phase(uvm_phase phase);
        m_cfg=env_config::type_id::create("m_cfg");
    
        super.end_of_elaboration_phase(phase);
        `uvm_info("ROUTER_ENV","This is end_of_elaboration phase of router_env", UVM_LOW)
endfunction
    
     
    task run_phase(uvm_phase phase);
        super.run();
        phase.raise_objection(this);
        #100;
        `uvm_info("ENVIRONMENT", "This is run phase in environment", UVM_LOW)
        phase.drop_objection(this);
    endtask

endclass

