`timescale 1 ns / 1 ps
`define DUMPSTR(x) `"x.vcd`"

module top_tb();

parameter DURATION = 2_000_000;

reg clk = 0;
reg rst = 1;
wire [7:0] led;

always #40 clk = ~clk;

top #(
  .COUNT_WIDTH(12),
  .COUNT(1000 - 1)
) UUT (
  .clk(clk),
  .rst(rst),
  .led(led)
);

initial begin
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, top_tb);

  rst = 1;
  #200;
  rst = 0;

  #(DURATION/2);
  rst = 1;
  #200;
  rst = 0;

  #(DURATION/2);
  $display("End of simulation");
  $finish;
end

endmodule
