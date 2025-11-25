`timescale 10ms / 1ms
`define DUMPSTR(x) `"x.vcd`"

module top_tb();

parameter DURATION = 650;

reg clk = 0;
wire out;
reg rst;
reg Enable = 0;
reg data_point = 1;
reg data_clk = 0;

top UUT (
    .clk(clk),
    .rst(rst),
    .data_clk(data_clk),
    .Enable(Enable),
    .data_point(data_point)
);

initial begin
    rst = 1;
    #15;
    rst = 0;
    #25;
    Enable = 1;
    data_point = 0;
    #20;
    data_point = 1;
    #20;
    data_point = 0;
    #20;
    data_point = 1;
    #20;
    data_point = 0;
    #20;
    data_point = 1;
    #20;
    data_point = 0;
    #20;
    data_point = 1;
    #20;
    data_point = 0;
    #20;
    data_point = 1;
    #20;
    data_point = 1;
    Enable = 0;
    #50;
    Enable = 1;
    data_point = 0;
    #20;
    data_point = 0;
    #20;
    data_point = 0;
    #20;
    data_point = 0;
    #20;
    data_point = 1;
    #20;
    data_point = 1;
    #20;
    data_point = 1;
    #20;
    data_point = 1;
    #20;
    data_point = 0;
    #20;
    data_point = 1;
    Enable = 0;
end

always begin
    #2 clk = ~clk;
end

always begin
    #10 data_clk = ~data_clk;
end

initial begin
    $dumpfile(`DUMPSTR(`VCD_OUTPUT));
    $dumpvars(0, top_tb);
    #(DURATION) $display("Simulation completed");
    $finish;
end

endmodule