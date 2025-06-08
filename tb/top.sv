
module top;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import tff_pkg::*;


  // Clock and reset
    bit clk;
    tff_if tff_if_inst(clk);

  // DUT instance
    tff dut (
    .clk(clk),
    .resetn(tff_if_inst.resetn),
    .t(tff_if_inst.t),
    .q(tff_if_inst.q)
  );

  
    always 
        #5 clk = ~clk;

  // Reset generation
    initial begin
        tff_if_inst.resetn = 0;
        #20;
        tff_if_inst.resetn = 1;
    end


    initial begin
    
        `ifdef VCS
         $fsdbDumpvars(0, top);
        `endif
        
        uvm_config_db #(virtual tff_if)::set(null,"*","vif",tff_if_inst);
        
        run_test();
    end

endmodule

