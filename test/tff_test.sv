
class tff_test extends uvm_test;

    `uvm_component_utils(tff_test)
    
    environment env;
    env_config m_cfg;
    write_agent_config wr_cfg;

    function new(string name="tff_test", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
       
       super.build_phase(phase);
       m_cfg=env_config::type_id::create("m_cfg");
       
       if(m_cfg.has_wagent)  begin
            m_cfg.wr_cfg = write_agent_config::type_id::create("wr_cfg", this);
        end
        
        wr_cfg = write_agent_config::type_id::create("wr_cfg");
        if(!uvm_config_db #(virtual tff_if)::get(this,"","vif",wr_cfg.vif))
            `uvm_fatal("VIF CONFIG - WRITE","cannot get() vif from uvm_config_db, have you set() it?")
        
        wr_cfg.is_active = UVM_ACTIVE;
        m_cfg.wr_cfg = wr_cfg;
        
        uvm_config_db #(env_config)::set(this,"*","env_config",m_cfg);
        env = environment::type_id::create("env", this);
    endfunction
    
    
endclass



class tff_random_test extends tff_test;

    `uvm_component_utils(tff_random_test)
    
    write_rand_seq wr_seqh;
    
    function new(string name="tff_random_test",uvm_component parent);
        super.new(name,parent);
    endfunction
    
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
    
    function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        `uvm_info("TEST", "Printing UVM topology", UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction
    
    task run_phase(uvm_phase phase);

        phase.raise_objection(this);
        wr_seqh = write_rand_seq::type_id::create("wr_seqh"); 
        wr_seqh.start(env.wr_agt_top.wr_agent.seqr);
        phase.drop_objection(this);
    
    endtask

endclass


