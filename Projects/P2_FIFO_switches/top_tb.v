`timescale 1ns/1ps

module top_tb;
  // Main system clock (100 MHz)
  reg clk = 0;
  always #5 clk = ~clk;

  // Active-low buttons (1 = unpressed, 0 = pressed)
  reg reset_btn = 1;
  reg push_btn  = 1;
  reg pop_btn   = 1;

  // 4-bit switch input
  reg [3:0] sw = 4'b0000;

  // LED output from DUT (active-low on hardware)
  wire [7:0] leds;

  // Internal wires to observe clocks from DUT
  wire wr_clk, rd_clk;

  // Instantiate DUT
  top uut (
    .clk(clk),
    .reset_btn(reset_btn),
    .push_btn(push_btn),
    .pop_btn(pop_btn),
    .sw(sw),
    .leds(leds)
  );

  // Tap into the internal divided clocks
  assign wr_clk = uut.wr_clk;
  assign rd_clk = uut.rd_clk;

  initial begin
    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);

    // Reset sequence
    reset_btn = 0; #100;
    reset_btn = 1; #500;

    // Push 8 values (0001 to 1000)
    sw = 4'b0001;
    repeat (8) begin
      push_btn = 0; #50; push_btn = 1;
      #50000; // wait for wr_clk domain to capture
      sw = sw + 1;
    end

    // Wait some time (FIFO full)
    #200000;

    // Pop 8 values
    repeat (8) begin
      pop_btn = 0; #50; pop_btn = 1;
      #50000; // wait for rd_clk domain to capture
    end

    #200000;
    $finish;
  end
endmodule
