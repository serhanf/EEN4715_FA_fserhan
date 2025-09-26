// -- apio init -t top -b icestick
// -- apio verify
// -- apio sim
//-------------------------------------
module top(
    input  wire clk,
    input  wire rst,
    output reg [7:0] led
);

parameter COUNT_WIDTH = 32;
parameter [COUNT_WIDTH-1:0] COUNT = 6_000_000 - 1;

reg [COUNT_WIDTH-1:0] count;
reg [7:0] counter;

initial begin
    led     <= 0;
    count   <= 0;
    counter <= 0;
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        count   <= 0;
        counter <= 0;
        led     <= 0;
    end else if (count == COUNT) begin
        count   <= 0;
        counter <= counter + 1;
        led     <= counter;
    end else begin
        count <= count + 1;
    end
end

endmodule
