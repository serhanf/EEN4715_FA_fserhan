// Testbench

`timescale 100 ns / 10 ns
`define DUMPSTR(x) `"x.vcd`"

module top_tb();

parameter DURATION = 10; 

wire test1;

top UUT (
        .D1(test1)
    );

initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, top_tb);

   #(DURATION) $display("End of simulation");
  $finish;

end

endmodule

