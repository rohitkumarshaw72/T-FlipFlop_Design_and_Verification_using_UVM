
class write_agent_top extends uvm_env;

    `uvm_component_utils(write_agent_top)
    
    write_agent wr_agent;
    env_config m_cfg;

    function new(string name="write_agent_top", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
            `uvm_fatal(get_type_name(), "ENV: source error")
        wr_agent = write_agent::type_id::create("wr_agent", this);
        uvm_config_db #(write_agent_config)::set(this,"*","write_agent_config", m_cfg.wr_cfg);
    endfunction
    
endclass

