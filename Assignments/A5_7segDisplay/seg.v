module seg (input clk_in, input rst, output reg [0:7] seg, output reg d1, d2, d3, d4);

    reg [3:0] counter = 0;
    


    initial begin
        seg[0:7] = ~8'b00000011; // 0
        d1 <= 0; 
        d2 <= 1;
        d3 <= 1;
        d4 <= 1;
    end

    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            counter <= 0;
            seg[0:7] <= ~8'b00000011; // 0
        end else begin
            counter <= counter + 1;
            if (counter > 4'hF) counter <= 0;
            
            case (counter)
                4'h0: seg[0:7] <= ~8'b00000011; // 0
                4'h1: seg[0:7] <= ~8'b10011111; // 1
                4'h2: seg[0:7] <= ~8'b00100101; // 2
                4'h3: seg[0:7] <= ~8'b00001101; // 3
                4'h4: seg[0:7] <= ~8'b10011001; // 4
                4'h5: seg[0:7] <= ~8'b01001001; // 5
                4'h6: seg[0:7] <= ~8'b01000001; // 6
                4'h7: seg[0:7] <= ~8'b00011111; // 7
                4'h8: seg[0:7] <= ~8'b00000001; // 8
                4'h9: seg[0:7] <= ~8'b00001001; // 9
                4'hA: seg[0:7] <= ~8'b00010001; // A
                4'hB: seg[0:7] <= ~8'b11000001; // b 
                4'hC: seg[0:7] <= ~8'b01100011; // C
                4'hD: seg[0:7] <= ~8'b10000101; // d
                4'hE: seg[0:7] <= ~8'b01100001; // E
                4'hF: seg[0:7] <= ~8'b01110001; // F
            endcase
        end
    end


    // Digit enable logic 
    always @(counter) begin
        d1 = 0;  // Enable first digit only
        d2 = 1;
        d3 = 1;
        d4 = 1;
    end

endmodule