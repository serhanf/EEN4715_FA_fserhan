module rd_clk_divider(
    input  wire clk_in,
    input  wire reset,
    output reg  clk_out
);
    reg [3:0] count;  
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count   <= 4'd0;
            clk_out <= 1'b0;
        end else begin
            if (count == 4'd8) begin  
                count   <= 4'd0;
                clk_out <= ~clk_out;
            end else begin
                count <= count + 4'd1;
            end
        end
    end
endmodule