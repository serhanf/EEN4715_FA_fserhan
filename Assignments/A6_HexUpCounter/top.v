module top (
    input clk, 
    input rst, 
    output div_clk, 
    output [0:7] seg, 
    output digit1, digit2, digit3, digit4
);
    
    clock_divider #(.DIVISOR(3_000_000)) clock_divider_instance (
        .clk_in(clk), 
        .reset(rst), 
        .clk_out(div_clk) 
    );

    seg seg_instance (
        .clk_in(clk),           // Fast clock 
        .slow_clk(div_clk),     // Slow clock 
        .rst(rst),
        .seg(seg),
        .d1(digit1),
        .d2(digit2),
        .d3(digit3),
        .d4(digit4)
    );

endmodule