// Testbench

`timescale 1 ns / 1 ps
`define DUMPSTR(x) `"x.vcd`"

module top_tb ();

parameter DURATION = 100000; 
reg clk = 0;
wire out;


top UUT (
        .out(out),
        .clk(clk)
    );

always begin
  #40
  clk = ~clk;
end 

 

initial begin


  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, top_tb);

   #(DURATION) $display("End of simulation");
  $finish;

end

endmodule

