
package tff_pkg;

    import uvm_pkg::*;
    
    `include "uvm_macros.svh"
    `include "write_transaction.sv"
    `include "write_agent_config.sv"
    `include "env_config.sv"
    
    `include "write_driver.sv"
    `include "write_monitor.sv"
    `include "write_sequencer.sv"
    `include "write_agent.sv"
    `include "write_agent_top.sv"
    `include "write_sequences.sv"
       
    `include "virtual_sequencer.sv"
    `include "scoreboard.sv"
    
    `include "environment.sv"

    `include "tff_test.sv"

endpackage
