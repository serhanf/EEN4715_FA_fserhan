module wr_clk_divider(
    input  wire clk_in,
    input  wire reset,
    output reg  clk_out
);
    reg toggle;
    
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            toggle <= 0;
            clk_out <= 0;
        end else begin
            toggle <= ~toggle;
            if (toggle) clk_out <= ~clk_out;
        end
    end
endmodule