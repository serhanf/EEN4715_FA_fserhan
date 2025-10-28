module seg (
    input clk_in,
    input rst,
    output reg [0:7] seg,
    output reg d1, d2, d3, d4
);

    reg [3:0] digit1 = 0; 
    reg [3:0] digit2 = 0;
    reg [3:0] digit3 = 0;
    reg [3:0] digit4 = 0; 
    
    reg [1:0] display_sel = 0;


    
    // Fast display multiplexing counter
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            display_sel <= 0;
        end else begin
            display_sel <= display_sel + 1;
        end
    end


    
    // Main counting logic 
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            digit1 <= 0;
            digit2 <= 0;
            digit3 <= 0;
            digit4 <= 0;
        end else begin
            // Always increment rightmost digit
            digit4 <= digit4 + 1;
            
            // Carry logic - when digit4 reaches F, increment digit3
            if (digit4 == 4'hF) begin
                digit4 <= 0;
                digit3 <= digit3 + 1;
            end
            
            // When digit3 reaches F, increment digit2
            if (digit3 == 4'hF && digit4 == 4'hF) begin
                digit3 <= 0;
                digit2 <= digit2 + 1;
            end
            
            // When digit2 reaches F, increment digit1
            if (digit2 == 4'hF && digit3 == 4'hF && digit4 == 4'hF) begin
                digit2 <= 0;
                digit1 <= digit1 + 1;
            end
        end
    end

    // Display multiplexing 
    always @(*) begin
        case (display_sel)
            2'b00: begin
                // Show digit1 (leftmost)
                case (digit1)
                    4'h0: seg = ~8'b00000011; // 0
                    4'h1: seg = ~8'b10011111; // 1
                    4'h2: seg = ~8'b00100101; // 2
                    4'h3: seg = ~8'b00001101; // 3
                    4'h4: seg = ~8'b10011001; // 4
                    4'h5: seg = ~8'b01001001; // 5
                    4'h6: seg = ~8'b01000001; // 6
                    4'h7: seg = ~8'b00011111; // 7
                    4'h8: seg = ~8'b00000001; // 8
                    4'h9: seg = ~8'b00001001; // 9
                    4'hA: seg = ~8'b00010001; // A
                    4'hB: seg = ~8'b11000001; // b
                    4'hC: seg = ~8'b01100011; // C
                    4'hD: seg = ~8'b10000101; // d
                    4'hE: seg = ~8'b01100001; // E
                    4'hF: seg = ~8'b01110001; // F
                endcase
                d1 = 0; d2 = 1; d3 = 1; d4 = 1;
            end
            2'b01: begin
                // Show digit2
                case (digit2)
                    4'h0: seg = ~8'b00000011; // 0
                    4'h1: seg = ~8'b10011111; // 1
                    4'h2: seg = ~8'b00100101; // 2
                    4'h3: seg = ~8'b00001101; // 3
                    4'h4: seg = ~8'b10011001; // 4
                    4'h5: seg = ~8'b01001001; // 5
                    4'h6: seg = ~8'b01000001; // 6
                    4'h7: seg = ~8'b00011111; // 7
                    4'h8: seg = ~8'b00000001; // 8
                    4'h9: seg = ~8'b00001001; // 9
                    4'hA: seg = ~8'b00010001; // A
                    4'hB: seg = ~8'b11000001; // b
                    4'hC: seg = ~8'b01100011; // C
                    4'hD: seg = ~8'b10000101; // d
                    4'hE: seg = ~8'b01100001; // E
                    4'hF: seg = ~8'b01110001; // F
                endcase
                d1 = 1; d2 = 0; d3 = 1; d4 = 1;
            end
            2'b10: begin
                // Show digit3
                case (digit3)
                    4'h0: seg = ~8'b00000011; // 0
                    4'h1: seg = ~8'b10011111; // 1
                    4'h2: seg = ~8'b00100101; // 2
                    4'h3: seg = ~8'b00001101; // 3
                    4'h4: seg = ~8'b10011001; // 4
                    4'h5: seg = ~8'b01001001; // 5
                    4'h6: seg = ~8'b01000001; // 6
                    4'h7: seg = ~8'b00011111; // 7
                    4'h8: seg = ~8'b00000001; // 8
                    4'h9: seg = ~8'b00001001; // 9
                    4'hA: seg = ~8'b00010001; // A
                    4'hB: seg = ~8'b11000001; // b
                    4'hC: seg = ~8'b01100011; // C
                    4'hD: seg = ~8'b10000101; // d
                    4'hE: seg = ~8'b01100001; // E
                    4'hF: seg = ~8'b01110001; // F
                endcase
                d1 = 1; d2 = 1; d3 = 0; d4 = 1;
            end
            2'b11: begin
                // Show digit4 (rightmost)
                case (digit4)
                    4'h0: seg = ~8'b00000011; // 0
                    4'h1: seg = ~8'b10011111; // 1
                    4'h2: seg = ~8'b00100101; // 2
                    4'h3: seg = ~8'b00001101; // 3
                    4'h4: seg = ~8'b10011001; // 4
                    4'h5: seg = ~8'b01001001; // 5
                    4'h6: seg = ~8'b01000001; // 6
                    4'h7: seg = ~8'b00011111; // 7
                    4'h8: seg = ~8'b00000001; // 8
                    4'h9: seg = ~8'b00001001; // 9
                    4'hA: seg = ~8'b00010001; // A
                    4'hB: seg = ~8'b11000001; // b
                    4'hC: seg = ~8'b01100011; // C
                    4'hD: seg = ~8'b10000101; // d
                    4'hE: seg = ~8'b01100001; // E
                    4'hF: seg = ~8'b01110001; // F
                endcase
                d1 = 1; d2 = 1; d3 = 1; d4 = 0;
            end
        endcase
    end

endmodule