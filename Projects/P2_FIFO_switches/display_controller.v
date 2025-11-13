module display_controller(
    input wire clk_in,
    input wire rst,
    input wire [3:0] input_data,
    input wire [3:0] output_data,
    input wire display_mode,
    input wire empty,
    input wire full,
    output reg [7:0] seg,
    output reg d1, d2, d3, d4
);
    
    reg [15:0] counter = 0;
    wire [1:0] sel = counter[15:14];
    reg [3:0] digit_val;
    
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            seg <= 8'b00000000;
            {d1,d2,d3,d4} <= 4'b1111;
        end else begin
            counter <= counter + 1;
            
            case (sel)
                2'b00: begin 
                    {d1,d2,d3,d4} = 4'b0111;
                    digit_val = display_mode ? 4'h0 : 4'h1;
                end
                2'b01: begin 
                    {d1,d2,d3,d4} = 4'b1011;
                    if (empty) digit_val = 4'hE;
                    else if (full) digit_val = 4'hF;
                    else digit_val = 4'hA;
                end
                2'b10: begin 
                    {d1,d2,d3,d4} = 4'b1101;
                    digit_val = 4'h0;
                end
                2'b11: begin 
                    {d1,d2,d3,d4} = 4'b1110;
                    digit_val = display_mode ? output_data : input_data;
                end
            endcase
            
            case (digit_val)
                4'h0: seg = (sel == 2'b10) ? 8'b00000000 : 8'b00111111;
                4'h1: seg = 8'b00000110;
                4'h2: seg = 8'b01011011;
                4'h3: seg = 8'b01001111;
                4'h4: seg = 8'b01100110;
                4'h5: seg = 8'b01101101;
                4'h6: seg = 8'b01111101;
                4'h7: seg = 8'b00000111;
                4'h8: seg = 8'b01111111;
                4'h9: seg = 8'b01101111;
                4'hA: seg = 8'b01110111;
                4'hE: seg = 8'b01111001;
                4'hF: seg = 8'b01110001;
                default: seg = 8'b00000000;
            endcase
        end
    end
endmodule