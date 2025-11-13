module FIFO(
    input  wire       WR_CLK,
    input  wire       RD_CLK,
    input  wire       rst,
    input  wire       push,
    input  wire       pop,
    input  wire [3:0] Data_In,
    output reg  [3:0] Data_Out,
    output wire       Full,
    output wire       Empty,
    output reg        Data_Valid
);

    reg [3:0] mem [0:7];
    reg [3:0] wr_ptr = 0;
    reg [3:0] rd_ptr = 0;
    reg [3:0] rd_ptr_wr1, rd_ptr_wr2;
    reg [3:0] wr_ptr_rd1, wr_ptr_rd2;

    always @(posedge WR_CLK or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
        end else if (push && !Full) begin
            mem[wr_ptr[2:0]] <= Data_In;
            wr_ptr <= wr_ptr + 1;
        end
    end

    always @(posedge RD_CLK or posedge rst) begin
        if (rst) begin
            rd_ptr <= 0;
            Data_Out <= 0;
            Data_Valid <= 0;
        end else begin
            Data_Valid <= 0;
            if (pop && !Empty) begin
                Data_Out <= mem[rd_ptr[2:0]];
                rd_ptr <= rd_ptr + 1;
                Data_Valid <= 1;
            end
        end
    end

    always @(posedge WR_CLK) begin
        rd_ptr_wr1 <= rd_ptr;
        rd_ptr_wr2 <= rd_ptr_wr1;
    end

    always @(posedge RD_CLK) begin
        wr_ptr_rd1 <= wr_ptr;
        wr_ptr_rd2 <= wr_ptr_rd1;
    end

    assign Empty = (wr_ptr_rd2 == rd_ptr);
    assign Full = (wr_ptr[2:0] == rd_ptr_wr2[2:0]) && (wr_ptr[3] != rd_ptr_wr2[3]);

endmodule