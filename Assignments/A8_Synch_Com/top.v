module top(
    input clk,
    input rst,
    input data_clk,
    input Enable,
    input data_point,
    output [7:0] seg,
    output [3:0] dig,
    output parity_bit
);

    wire div_clk;
    wire [7:0] numb;

    clock_divider #(.DIVISOR(90))
    clock_divider_instance (
        .clk_in(clk),
        .reset(rst),
        .clk_div(div_clk)
    );

    SynchRx SynchRx_instance(
        .reset(rst),
        .data_clk(data_clk),
        .data_point(data_point),
        .Enable(Enable),
        .numb(numb),
        .parity_bit(parity_bit)
    );

    seg seg_instance(
        .clk(clk),
        .reset(rst),
        .numb(numb),
        .parity1(parity_bit),
        .seg(seg),
        .dig(dig)
    );

endmodule