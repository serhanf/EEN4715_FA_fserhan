module seg (
    input wire clk,
    input wire reset,
    input [7:0] numb,
    input wire parity1,
    output reg [7:0] seg,
    output reg [3:0] dig
);

    reg [3:0] current_value;
    reg [1:0] digit_select;
    reg [15:0] slow;

    wire [3:0] low_nibble  = numb[3:0];
    wire [3:0] high_nibble = numb[7:4];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            slow <= 0;
            digit_select <= 0;
        end else begin
            slow <= slow + 1;
            if (slow == 10000) begin
                slow <= 0;
                digit_select <= digit_select + 1;
            end
        end
    end

    always @(*) begin
        case (digit_select)
            2'b00: begin
                current_value = parity1 ? 4'd1 : 4'd0;  
                dig = 4'b1110;
            end
            2'b01: begin
                current_value = high_nibble;  
                dig = 4'b1101;
            end
            2'b10: begin
                current_value = low_nibble;  
                dig = 4'b1011;
            end
            2'b11: begin
                current_value = 4'd0;         
                dig = 4'b0111;
            end
        endcase
    end

    always @(*) begin
        case (current_value)
            4'h0: seg = 8'b00111111;
            4'h1: seg = 8'b00000110;
            4'h2: seg = 8'b01011011;
            4'h3: seg = 8'b01001111;
            4'h4: seg = 8'b01100110;
            4'h5: seg = 8'b01101101;
            4'h6: seg = 8'b01111101;
            4'h7: seg = 8'b00000111;
            4'h8: seg = 8'b01111111;
            4'h9: seg = 8'b01100111;
            4'hA: seg = 8'b01110111;
            4'hB: seg = 8'b01111100;
            4'hC: seg = 8'b00111001;
            4'hD: seg = 8'b01011110;
            4'hE: seg = 8'b01111001;
            4'hF: seg = 8'b01110001;
            default: seg = 8'b00000000;
        endcase
    end
endmodule