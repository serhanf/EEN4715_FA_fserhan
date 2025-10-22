// Testbench

`timescale 10 ms / 1 ms
`define DUMPSTR(x) `"x.vcd`"

module top_tb();

parameter DURATION = 1_000_000; 

reg clk = 0;
wire out;
reg rst;
wire [0:7] seg;
wire d1, d2, d3, d4;


top UUT (
        .clk(clk),
        .rst(rst),
        .div_clk(out),
        .seg(seg),
        .digit1(d1),
        .digit2(d2),
        .digit3(d3),
        .digit4(d4)
    );

initial begin
  rst = 1;
  #10;
  rst = 0;
end

always begin
    #40
    clk=~clk;
end


initial begin

  //-- File were to store the simulation results
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, top_tb);

   #(DURATION) $display("End of simulation");
  $finish;

end

endmodule