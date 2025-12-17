module pwm_gen (
    input wire clk,
    input wire reset,
    input wire [31:0] period,
    output reg pwm_out
);
    reg [31:0] counter;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (period <= 1) begin
                counter <= 0;
                pwm_out <= 0;
            end else begin
                if (counter >= period - 1)
                    counter <= 0;
                else
                    counter <= counter + 1;
                pwm_out <= (counter < (period >> 1));
            end
        end
    end
endmodule
