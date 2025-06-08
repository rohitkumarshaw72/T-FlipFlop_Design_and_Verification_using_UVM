
interface tff_if(input logic clk);

  // DUT Signals
  logic resetn;
  logic t;
  logic q;

  // Clocking block for DRIVER
  clocking cb_drv @(posedge clk);
    output t, resetn;
  endclocking

  // Clocking block for MONITOR
  clocking cb_mon @(posedge clk);
    input t, q, resetn;
  endclocking

  // Modport for DRIVER
  modport DRIVER (
    clocking cb_drv
  );

  // Modport for MONITOR
  modport MONITOR (
    clocking cb_mon
  );

endinterface

