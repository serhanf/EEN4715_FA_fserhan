module FIFO(
    input  wire       WR_CLK,
    input  wire       RD_CLK,
    input  wire       rst,
    input  wire       push,
    input  wire       pop,
    input  wire [3:0] Data_In,
    output reg  [3:0] Data_Out,
    output reg        Full,
    output reg        Empty,
    output reg        Data_Valid
);
    reg [3:0] mem [0:7];
    reg [3:0] wr_ptr;
    reg [3:0] rd_ptr;
    reg [3:0] rd_ptr_wr1, rd_ptr_wr2;
    reg [3:0] wr_ptr_rd1, wr_ptr_rd2;

    always @(posedge WR_CLK or posedge rst) begin
        if (rst) begin
            wr_ptr     <= 4'd0;
            rd_ptr_wr1 <= 4'd0;
            rd_ptr_wr2 <= 4'd0;
        end else begin
            rd_ptr_wr1 <= rd_ptr;
            rd_ptr_wr2 <= rd_ptr_wr1;
            if (push && !Full) begin
                mem[wr_ptr[2:0]] <= Data_In;
                wr_ptr <= wr_ptr + 1'b1;
            end
        end
    end

    always @(posedge RD_CLK or posedge rst) begin
        if (rst) begin
            rd_ptr     <= 4'd0;
            wr_ptr_rd1 <= 4'd0;
            wr_ptr_rd2 <= 4'd0;
            Data_Out   <= 4'd0;
            Data_Valid <= 1'b0;
        end else begin
            wr_ptr_rd1 <= wr_ptr;
            wr_ptr_rd2 <= wr_ptr_rd1;
            Data_Valid <= 1'b0;
            if (pop && !Empty) begin
                Data_Out   <= mem[rd_ptr[2:0]];
                rd_ptr     <= rd_ptr + 1'b1;
                Data_Valid <= 1'b1;
            end
        end
    end

    always @(*) begin
        Empty = (wr_ptr_rd2 == rd_ptr);
        Full  = (wr_ptr[2:0] == rd_ptr_wr2[2:0]) && (wr_ptr[3] != rd_ptr_wr2[3]);
    end
endmodule
