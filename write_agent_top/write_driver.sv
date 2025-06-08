
class write_driver extends uvm_driver #(write_transaction);

    `uvm_component_utils(write_driver)

    virtual tff_if.DRIVER vif;
    write_agent_config wr_cfg;

    write_transaction tr;
    
    function new(string name="write_driver", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        if (!uvm_config_db #(write_agent_config)::get(this, "", "write_agent_config", wr_cfg))
            `uvm_fatal("WRITE_DRIVER", "cannot get() wr_cfg from uvm_config_db, have you set() it?")

    endfunction


    function void connect_phase(uvm_phase phase);

        vif = wr_cfg.vif;

    endfunction

    task run_phase(uvm_phase phase);
        
        forever begin
            @(vif.cb_drv);
            vif.cb_drv.resetn <= tr.resetn;
            vif.cb_drv.t     <= tr.t;
            
            seq_item_port.get_next_item(tr);
            send_to_dut(tr);
            seq_item_port.item_done();
        end
    endtask
    
    task send_to_dut(write_transaction tr);
        vif.cb_drv.t <= tr.t;
            @(vif.cb_drv);
    endtask
    
endclass

