module SynchRx (
    input reset,
    input data_clk,
    input data_point,
    input Enable,
    output reg [7:0] numb,
    output reg parity_bit
);

    localparam IDLE = 4'd0;
    localparam START = 4'd1;
    localparam BIT0 = 4'd2;
    localparam BIT1 = 4'd3;
    localparam BIT2 = 4'd4;
    localparam BIT3 = 4'd5;
    localparam BIT4 = 4'd6;
    localparam BIT5 = 4'd7;
    localparam BIT6 = 4'd8;
    localparam BIT7 = 4'd9;
    localparam PARITY = 4'd10;
    localparam STOP = 4'd11;

    reg [3:0] state;
    reg [7:0] value;
    reg parity_val;

    always @ (posedge data_clk or posedge reset) begin
        if (reset == 1'b1) begin
            value <= 8'b0;
            state <= IDLE;
            numb <= 8'b00000000;
            parity_val <= 0;
            parity_bit <= 0;
        end else begin
            case(state)
                IDLE: begin
                    if (Enable == 1'b1 && data_point == 1'b0) begin
                        state <= START;
                    end
                end
                START: begin
                    state <= BIT0;
                end
                BIT0: begin
                    value[0] <= data_point;
                    state <= BIT1;
                end
                BIT1: begin
                    value[1] <= data_point;
                    state <= BIT2;
                end
                BIT2: begin
                    value[2] <= data_point;
                    state <= BIT3;
                end
                BIT3: begin
                    value[3] <= data_point;
                    state <= BIT4;
                end
                BIT4: begin
                    value[4] <= data_point;
                    state <= BIT5;
                end
                BIT5: begin
                    value[5] <= data_point;
                    state <= BIT6;
                end
                BIT6: begin
                    value[6] <= data_point;
                    state <= BIT7;
                end
                BIT7: begin
                    value[7] <= data_point;
                    state <= PARITY;
                end
                PARITY: begin
                    parity_val <= data_point;
                    state <= STOP;
                end
                STOP: begin
                    numb <= value;
                    parity_bit <= parity_val;
                    state <= IDLE;
                end
                default: state <= IDLE;
            endcase
        end
    end
endmodule