module tone_selector #(
    parameter integer CLOCK_FREQ = 12000000
)(
    input wire [3:0] note_sel,
    output reg [31:0] period_value
);
    localparam integer C4  = CLOCK_FREQ / 262;
    localparam integer D4  = CLOCK_FREQ / 294;
    localparam integer E4  = CLOCK_FREQ / 330;
    localparam integer F4  = CLOCK_FREQ / 349;
    localparam integer G4  = CLOCK_FREQ / 392;
    localparam integer A4  = CLOCK_FREQ / 440;
    localparam integer B4  = CLOCK_FREQ / 494;
    localparam integer C5  = CLOCK_FREQ / 523;
    localparam integer D5  = CLOCK_FREQ / 587;
    localparam integer E5  = CLOCK_FREQ / 659;
    localparam integer F5  = CLOCK_FREQ / 698;
    localparam integer G5  = CLOCK_FREQ / 784;
    localparam integer A5  = CLOCK_FREQ / 880;
    localparam integer B5  = CLOCK_FREQ / 988;
    localparam integer C6  = CLOCK_FREQ / 1047;
    localparam integer D6  = CLOCK_FREQ / 1175;

    always @* begin
        case (note_sel)
            4'b0000: period_value = C4;
            4'b0001: period_value = D4;
            4'b0010: period_value = E4;
            4'b0011: period_value = F4;
            4'b0100: period_value = G4;
            4'b0101: period_value = A4;
            4'b0110: period_value = B4;
            4'b0111: period_value = C5;
            4'b1000: period_value = D5;
            4'b1001: period_value = E5;
            4'b1010: period_value = F5;
            4'b1011: period_value = G5;
            4'b1100: period_value = A5;
            4'b1101: period_value = B5;
            4'b1110: period_value = C6;
            4'b1111: period_value = D6;
            default: period_value = A4;
        endcase
    end
endmodule
