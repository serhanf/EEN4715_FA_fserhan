module clock_divider #(
    parameter DIVISOR = 90
)(
    input clk_in,
    input reset,
    output reg clk_div
);
    reg [31:0] counter;
    
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_div <= 0;
        end else begin
            if (counter >= (DIVISOR - 1)) begin
                counter <= 0;
                clk_div <= ~clk_div;
            end else begin
                counter <= counter + 1;
            end
        end
    end
    
endmodule