module top(
    input  wire       clk,
    input  wire [7:0] sw,
    output wire [7:0] leds,
    output wire [7:0] seg,
    output wire       d1, d2, d3, d4
);

    // FIXED: Invert switches for active-low
    wire [3:0] data_in = ~sw[3:0];  // Invert data switches
    wire push = ~sw[4];             // Invert push button
    wire pop = ~sw[5];              // Invert pop button
    wire rst = ~sw[6];              // Invert reset button
    wire mode = ~sw[7];             // Invert mode switch

    wire wr_clk, rd_clk;
    wr_clk_divider wr_clk_gen(.clk_in(clk), .reset(rst), .clk_out(wr_clk));
    rd_clk_divider rd_clk_gen(.clk_in(clk), .reset(rst), .clk_out(rd_clk));

    wire [3:0] fifo_out;
    wire full, empty, data_valid;
    
    FIFO my_fifo(
        .WR_CLK(wr_clk),
        .RD_CLK(rd_clk),
        .rst(rst),
        .push(push && !full),
        .pop(pop && !empty),
        .Data_In(data_in),
        .Data_Out(fifo_out),
        .Full(full),
        .Empty(empty),
        .Data_Valid(data_valid)
    );

    reg push_led;
    always @(posedge wr_clk) begin
        push_led <= push && !full;
    end
    
    assign leds[3:0] = fifo_out;
    assign leds[4] = empty;
    assign leds[5] = full;
    assign leds[6] = data_valid;
    assign leds[7] = push_led;

    display_controller display(
        .clk_in(clk),
        .rst(rst),
        .input_data(data_in),
        .output_data(fifo_out),
        .display_mode(mode),
        .empty(empty),
        .full(full),
        .seg(seg),
        .d1(d1), .d2(d2), .d3(d3), .d4(d4)
    );

endmodule