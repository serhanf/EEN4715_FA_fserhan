// Testbench

`timescale 1 ns / 1 ns
`define DUMPSTR(x) `"x.vcd`"

module top_tb;

parameter DURATION = 5; 

reg a;
reg b;

wire and_o;
wire nand_o;
wire or_o;
wire nor_o;
wire xor_o;
wire xnor_o;
wire not_o;


top UUT (
        .a(a),
        .b(b),
        .and_o(and_o),
        .nand_o(nand_o),
        .or_o(or_o),
        .nor_o(nor_o),
        .xnor_o(xnor_o),
        .xor_o(xor_o),
        .not_o(not_o)
    );



initial begin
  $dumpfile(`DUMPSTR(`VCD_OUTPUT));
  $dumpvars(0, top_tb);

a= 1'bx; b = 1'bx; #1;
a = 1'b0 ; b = 1'b0; #10;
a = 1'b0 ; b = 1'b1; #10;
a = 1'b1 ; b = 1'b0; #10;
a = 1'b1 ; b = 1'b1; #10;



   #(DURATION) $display("End of simulation");
  $finish;

end

endmodule

