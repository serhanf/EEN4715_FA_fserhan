module SynchRx (input reset, input clk, input wire clk_in, input wire data_clk, input data_point, input Enable, output reg value);



localparam state_0 = 2'd0;
localparam state_1 = 2'd1;
localparam state_2 = 2'd2;
localparam state_3 = 2'd3;


reg [2:0] state;





initial begin
   state <= state_0;
end


    always @ (posedge data_clk) begin
        if (reset == 1'b1) begin
            value <= 1'b0;
        end else begin
        case(state)
            state_0: begin
               if (Enable == 1'b1) begin
                state <= state_1;
                end else begin
                state <= state_0;
                end
            end

            state_1: begin
                value <= data_point;
                state <= state_0;
            end

   endcase
   end
end
   endmodule
