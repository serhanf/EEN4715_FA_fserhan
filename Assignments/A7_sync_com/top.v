module top (
    input wire clk,
    input wire rst,
    input wire data_clk,
    input wire data_point,
    input wire Enable,
    output wire value_out,
    output wire [7:0] seg,
    output wire dig
);

    // Synchronous Receiver instance
    SynchRx receiver (
        .reset(rst),
        .clk(clk),
        .clk_in(clk),
        .data_clk(data_clk),
        .data_point(data_point),
        .Enable(Enable),
        .value(value_out)
    );

    // Segment display instance
    seg segment_display (
        .clk(clk),
        .clk_in(clk),
        .reset(rst),
        .value(value_out),
        .seg(seg),
        .dig(dig)
    );

endmodule