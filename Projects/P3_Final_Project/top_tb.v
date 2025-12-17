`timescale 1ns/1ps

module top_tb;

    reg        clk;
    reg        reset;
    reg  [3:0] switches;
    wire       audio_out;
    wire       status_led;
    wire [3:0] dig;
    wire [7:0] seg;

    top uut (
        .clk       (clk),
        .reset     (reset),
        .switches  (switches),
        .audio_out (audio_out),
        .status_led(status_led),
        .dig       (dig),
        .seg       (seg)
    );

    always #5 clk = ~clk;

    initial begin
        clk      = 1'b0;
        reset    = 1'b1;
        switches = 4'b0000;

        $dumpfile("top_tb.vcd");
        $dumpvars(0, top_tb);

        #100;
        reset = 1'b0;

        #1_000_000;
        switches = 4'b0001;
        #1_000_000;
        switches = 4'b0010;
        #1_000_000;
        switches = 4'b0011;
        #1_000_000;
        switches = 4'b0100;
        #1_000_000;
        switches = 4'b0101;
        #1_000_000;
        switches = 4'b0110;
        #1_000_000;
        switches = 4'b0111;
        #1_000_000;
        switches = 4'b1000;
        #1_000_000;
        switches = 4'b1001;
        #1_000_000;
        switches = 4'b1010;
        #1_000_000;
        switches = 4'b1011;
        #1_000_000;
        switches = 4'b1100;
        #1_000_000;
        switches = 4'b1101;
        #1_000_000;
        switches = 4'b1110;
        #1_000_000;
        switches = 4'b1111;
        #1_000_000;

        $finish;
    end

endmodule
