`timescale 1ns/1ps

module top_tb;

  // Clock/reset
  reg clk = 0;
  reg rst_n = 0;

  // Switches / buttons
  reg sw0, sw1, sw2, sw3, sw4, sw5, sw6, start_btn;

  // outputs
  wire [5:0] led;
  wire [7:0] sevenseg;
  wire rinse2, spin2;

  
  always #5 clk = ~clk;

  defparam uut.COUNT_WIDTH = 8;
  defparam uut.COUNT = 10-1;



  top uut (
    .clk(clk),
    .rst_n(rst_n),
    .sw0(sw0), .sw1(sw1), .sw2(sw2), .sw3(sw3),
    .sw4(sw4), .sw5(sw5), .sw6(sw6),
    .start_btn(start_btn),
    .led(led),
    .sevenseg(sevenseg),
    .rinse2(rinse2),
    .spin2(spin2)
  );


  initial begin
  

    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);

    // inputs
    sw0 = 0; sw1 = 0;   // SMALL 
    sw2 = 0; sw3 = 0;   // WARM 
    sw4 = 1;            // second rinse ON
    sw5 = 1;            // extra spin OFF
    sw6 = 0;            // lid CLOSED
    start_btn = 0;

    // Reset then start
     rst_n = 0;
     #10 rst_n = 1;
     #10 rst_n = 0;


    #40 start_btn = 1;
    #40 start_btn = 0;

    

    #5000;
    $finish;
  end

endmodule
