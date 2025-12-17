module clock_divider #(
    parameter integer DIVIDE_BY = 24000000
)(
    input wire clk_in,
    input wire reset,
    output reg clk_out
);
    reg [$clog2(DIVIDE_BY)-1:0] counter;
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == DIVIDE_BY-1) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule
