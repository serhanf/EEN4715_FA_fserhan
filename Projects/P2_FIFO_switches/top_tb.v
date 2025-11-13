`timescale 1ns/1ps

module top_tb;
    reg clk = 0;
    reg [7:0] sw = 0;
    wire [7:0] leds;
    

    reg wr_clk = 0;
    reg rd_clk = 0;

    always #5 clk = ~clk;      // 100MHz
    always #10 wr_clk = ~wr_clk; // 50MHz  
    always #15 rd_clk = ~rd_clk; // 33MHz

    top uut (.clk(clk), .sw(sw), .leds(leds));

    initial begin
        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);
        
        
        $dumpvars(1, wr_clk);
        $dumpvars(1, rd_clk);

        // Reset
        sw[6] = 1; #100; sw[6] = 0; #100;

        $display("=== Pushing 8 values ===");
        
        // Push 8 values
        sw[3:0] = 1; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 2; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 3; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 4; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 5; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 6; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 7; sw[4] = 1; #50; sw[4] = 0; #100;
        sw[3:0] = 8; sw[4] = 1; #50; sw[4] = 0; #100;

        $display("Full: %b", leds[5]);

        $display("=== Popping 8 values ===");
        
        // Pop 8 values
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;
        sw[5] = 1; #50; sw[5] = 0; #100;

        $display("Empty: %b", leds[4]);

        #100;
        $finish;
    end
endmodule