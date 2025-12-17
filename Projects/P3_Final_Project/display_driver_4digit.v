module display_driver_4digit (
    input wire clk,
    input wire reset,
    input wire [3:0] value,
    output reg [3:0] dig,
    output wire [7:0] seg
);
    reg [3:0] tens;
    reg [3:0] ones;

    always @* begin
        if (value < 10) begin
            tens = 4'd0;
            ones = value;
        end else begin
            tens = 4'd1;
            ones = value - 4'd10;
        end
    end

    reg [15:0] scan_counter;
    reg [1:0] current_digit;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            scan_counter <= 0;
            current_digit <= 0;
        end else begin
            scan_counter <= scan_counter + 1;
            if (scan_counter == 0)
                current_digit <= current_digit + 1;
        end
    end

    reg [3:0] current_value;

    always @* begin
        case (current_digit)
            2'd0: begin current_value = ones; dig = 4'b1110; end
            2'd1: begin current_value = tens; dig = 4'b1101; end
            2'd2: begin current_value = 4'hF; dig = 4'b1011; end
            2'd3: begin current_value = 4'hF; dig = 4'b0111; end
            default: begin current_value = 4'h0; dig = 4'b1111; end
        endcase
    end

    seven_seg_decoder u_dec (
        .value(current_value),
        .seg(seg)
    );
endmodule
