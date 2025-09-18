//--apio init -t top -b icestick 
//-- apio verify 
// -- apio sim 
//-------------------------------------
module top (input wire clk, output reg out);

parameter COUNT_WIDTH = 24;
parameter [COUNT_WIDTH-1:0] COUNT = 45;

reg [COUNT_WIDTH-1:0] count;

initial begin 
    out <= 0;
    count <=0;
end 

always @ (posedge clk) begin
    if (count == COUNT) begin
        count <= 0;
        out <= ~out;
    end else begin
        count <= count +1;
    end 
end


endmodule
