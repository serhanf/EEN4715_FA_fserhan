module rd_clk_divider(
    input  wire clk_in,
    input  wire reset,
    output reg  clk_out
);
    reg [1:0] count;
    
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count <= 0;
            clk_out <= 0;
        end else begin
            if (count == 2'd2) begin
                count <= 0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 1;
            end
        end
    end
endmodule