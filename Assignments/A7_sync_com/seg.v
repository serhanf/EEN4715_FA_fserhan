module seg (
    input wire clk,
    input  wire clk_in,    
    input  wire reset,  
    input value,    
    output reg [7:0] seg,   
    output reg dig     
);
initial begin
    dig = 1'b1;
    seg = ~8'b00000000;
end



    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) begin
            seg <= ~8'b00000000;
        end else begin
        if (value == 1'b0) begin
            seg = ~8'b11111100;
        end else if (value == 1'b1) begin
            seg = ~8'b01100000;

    end
end
end





    
endmodule