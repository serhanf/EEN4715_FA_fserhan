module keypad(
    input  wire       clk,
    input  wire       reset,
    output reg  [3:0] rows,
    input  wire [3:0] cols,
    output reg  [3:0] key_value,
    output reg        key_pressed
);
    reg [15:0] slow_cnt;
    reg [1:0]  row_sel;
    reg        held;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            slow_cnt    <= 16'd0;
            row_sel     <= 2'd0;
            rows        <= 4'b1110;
            key_value   <= 4'd0;
            key_pressed <= 1'b0;
            held        <= 1'b0;
        end else begin
            key_pressed <= 1'b0;
            slow_cnt <= slow_cnt + 1'b1;
            if (slow_cnt == 16'd0) begin
                row_sel <= row_sel + 1'b1;
                case (row_sel)
                    2'd0: rows <= 4'b1110;
                    2'd1: rows <= 4'b1101;
                    2'd2: rows <= 4'b1011;
                    2'd3: rows <= 4'b0111;
                endcase
            end
            if (cols != 4'b1111) begin
                if (!held) begin
                    held <= 1'b1;
                    casex ({rows, cols})
                        8'b1110_1110: key_value <= 4'h1;
                        8'b1110_1101: key_value <= 4'h2;
                        8'b1110_1011: key_value <= 4'h3;
                        8'b1110_0111: key_value <= 4'hA;
                        8'b1101_1110: key_value <= 4'h4;
                        8'b1101_1101: key_value <= 4'h5;
                        8'b1101_1011: key_value <= 4'h6;
                        8'b1101_0111: key_value <= 4'hB;
                        8'b1011_1110: key_value <= 4'h7;
                        8'b1011_1101: key_value <= 4'h8;
                        8'b1011_1011: key_value <= 4'h9;
                        8'b1011_0111: key_value <= 4'hC;
                        8'b0111_1110: key_value <= 4'hE; 
                        8'b0111_1101: key_value <= 4'h0;
                        8'b0111_1011: key_value <= 4'hF; 
                        8'b0111_0111: key_value <= 4'hD;
                        default: key_value <= 4'h0;
                    endcase
                    key_pressed <= 1'b1;
                end
            end else begin
                held <= 1'b0;
            end
        end
    end
endmodule
