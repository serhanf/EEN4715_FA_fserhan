// Verilog Hello world 
module top (
    input wire a,
    input wire b,
    output wire and_o,
    output wire nand_o,
    output wire or_o,
    output wire nor_o,
    output wire xnor_o,
    output wire xor_o,
    output wire not_o
);
    assign and_o = a&b;
    assign nand_o = ~(a&b);
    assign or_o = a|b;
    assign nor_o = ~ (a|b);
    assign xor_o = a^b;
    assign xnor_o = ~(a^b);
    assign not_o = ~a;
endmodule

