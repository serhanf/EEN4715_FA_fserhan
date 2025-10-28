module clock_divider (
    input clk_in,
    input reset,
    output reg clk_out  
);
    parameter DIVISOR = 13_000_000;

    reg [24:0] counter;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter >= DIVISOR - 1) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule