module clock_divider (input clk_in,
                    input reset,
                    output clk_out,
                    output reg clk_div
                    );

    reg clk;
   
    assign clk_out = clk_in;

     // Parameters
    localparam DIVISOR = 15000000; // 1second

    // Registers
    reg [24:0] counter;      // 25-bit counter (since 16,000,000 < 2^25)

    // Counter and led logic
    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_div <= 0;
        end else begin
            if (counter >= DIVISOR - 1) begin
                counter <= 0;
                clk_div <= ~clk_div;  // Toggle led2 state
            end else begin
                counter <= counter + 1;
            end
        end
    end


endmodule