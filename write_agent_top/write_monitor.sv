
class write_monitor extends uvm_monitor;

    `uvm_component_utils(write_monitor)

    virtual tff_if vif;
    write_agent_config wr_cfg;
    write_transaction tr;
    uvm_analysis_port #(write_transaction) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        ap = new("ap", this);
    endfunction

    function void build_phase(uvm_phase phase);

        if (!uvm_config_db #(write_agent_config)::get(this, "", "write_agent_config", wr_cfg))
            `uvm_fatal("WRITE_MONITOR", "cannot get() wr_cfg from uvm_config_db, have you set() it?")
                
    endfunction


    function void connect_phase(uvm_phase phase);

        vif = wr_cfg.vif;
                
    endfunction

    task run_phase(uvm_phase phase);
        forever begin
            @(vif.cb_mon);
            tr.resetn = vif.cb_mon.resetn;
            tr.t     = vif.cb_mon.t;
            tr.q     = vif.cb_mon.q;
            ap.write(tr);
        
            tr = write_transaction::type_id::create("tr");
            @(vif.cb_mon);
            tr.t = vif.cb_mon.t;
            tr.q = vif.cb_mon.q;

        `uvm_info("WRITE_MONITOR", "Displaying the source monitor data", UVM_MEDIUM)
        tr.print();
            ap.write(tr);
        end
    endtask
endclass

