module seg (
    input clk_in,        // Fast clock 
    input slow_clk,      // Slow clock 
    input rst,
    output reg [0:7] seg,
    output reg d1, d2, d3, d4
);

    reg [15:0] count = 0;
    reg [15:0] refresh_counter = 0;
    reg [1:0] digit_sel = 0;
    
    // 16-bit counter
    wire [3:0] digit1 = count[15:12]; // d1
    wire [3:0] digit2 = count[11:8];  //d2
    wire [3:0] digit3 = count[7:4];  // d3
    wire [3:0] digit4 = count[3:0];   // d4
    
    reg [3:0] current_digit;

    // Main counter - increments every second using slow clock
    always @(posedge slow_clk or posedge rst) begin
        if (rst) begin
            count <= 0;
        end else begin
            count <= count + 1;
        end
    end

    // Display multiplexing counter using fast clock (clk_in)
    always @(posedge clk_in or posedge rst) begin
        if (rst) begin
            refresh_counter <= 0;
            digit_sel <= 0;
        end else begin
            refresh_counter <= refresh_counter + 1;
            if (refresh_counter == 10000) begin 
                refresh_counter <= 0;
                digit_sel <= digit_sel + 1;
            end
        end
    end

    // Digit selection and segment data
    always @(*) begin
        case (digit_sel)
            2'b00: begin
                d1 = 0; d2 = 1; d3 = 1; d4 = 1;
                current_digit = digit1;
            end
            2'b01: begin
                d1 = 1; d2 = 0; d3 = 1; d4 = 1;
                current_digit = digit2;
            end
            2'b10: begin
                d1 = 1; d2 = 1; d3 = 0; d4 = 1;
                current_digit = digit3;
            end
            2'b11: begin
                d1 = 1; d2 = 1; d3 = 1; d4 = 0;
                current_digit = digit4;
            end
        endcase
    end

    // 7-segment 
    always @(*) begin
        case (current_digit)
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
    end

endmodule