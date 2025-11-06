module top_tb();

parameter DURATION = 1000;

// Inputs
reg clk = 0;
reg rst;
reg data_clk = 0;
reg data_point;
reg Enable;

// Outputs
wire value_out;
wire [7:0] seg;
wire dig;


top UUT (
    .clk(clk),
    .rst(rst),
    .data_clk(data_clk),
    .data_point(data_point),
    .Enable(Enable),
    .value_out(value_out),
    .seg(seg),
    .dig(dig)
);

// Clock generation
always #5 clk = ~clk;
always #20 data_clk = ~data_clk;


initial begin
  $dumpfile("top_tb.vcd");  
  $dumpvars(0, top_tb);
  
  // Initialize inputs
  rst = 1;
  Enable = 0;
  data_point = 0;
  
  // Release reset
  #15 rst = 0;
  
 
  #30 Enable = 1;
  #40 data_point = 1;
  #40 data_point = 0;
  #40 data_point = 1;
  #40 data_point = 0;
  
  #40 Enable = 0;
  #80 data_point = 1;
  #40 data_point = 0;
  
  #40 Enable = 1;
  #40 data_point = 1;
  #40 data_point = 0;
  #40 data_point = 1;
  
  #200 $display("End of simulation");
  $finish;
end


initial begin
  $monitor("Time=%0t, rst=%b, Enable=%b, data_point=%b, value_out=%b, seg=%8b", 
           $time, rst, Enable, data_point, value_out, seg);
end

endmodule