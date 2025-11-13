module top(
    input  wire       clk,
    input  wire       reset_btn,
    input  wire       push_btn,
    input  wire       pop_btn,
    output wire [7:0] leds,
    output wire [3:0] keypad_rows,
    input  wire [3:0] keypad_cols
);
    wire rst = ~reset_btn;
    
    
    wire wr_clk, rd_clk;
    wr_clk_divider u_wr(.clk_in(clk), .reset(rst), .clk_out(wr_clk));
    rd_clk_divider u_rd(.clk_in(clk), .reset(rst), .clk_out(rd_clk));

    
    reg p0,p1,q0,q1;
    reg push_tog, pop_tog;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            p0<=0; p1<=0; q0<=0; q1<=0;
            push_tog<=1'b0; pop_tog<=1'b0;
        end else begin
            p0<=push_btn; p1<=p0; if (p0 & ~p1) push_tog <= ~push_tog;
            q0<=pop_btn;  q1<=q0; if (q0 & ~q1)  pop_tog  <= ~pop_tog;
        end
    end

    
    reg [1:0] ps_wr; reg ps_wr_d; wire push_edge_wr;
    always @(posedge wr_clk or posedge rst) begin
        if (rst) begin ps_wr<=2'b00; ps_wr_d<=1'b0; end
        else begin ps_wr <= {ps_wr[0], push_tog}; ps_wr_d <= ps_wr[1]; end
    end
    assign push_edge_wr = ps_wr[1] ^ ps_wr_d;
    reg [2:0] push_str; wire push_pulse_wr;
    always @(posedge wr_clk or posedge rst) begin
        if (rst) push_str <= 3'd0;
        else if (push_edge_wr) push_str <= 3'd5;
        else if (push_str != 0) push_str <= push_str - 3'd1;
    end
    assign push_pulse_wr = (push_str != 0);

    
    reg [1:0] pp_rd; reg pp_rd_d; wire pop_edge_rd;
    always @(posedge rd_clk or posedge rst) begin
        if (rst) begin pp_rd<=2'b00; pp_rd_d<=1'b0; end
        else begin pp_rd <= {pp_rd[0], pop_tog}; pp_rd_d <= pp_rd[1]; end
    end
    assign pop_edge_rd = pp_rd[1] ^ pp_rd_d;
    reg [2:0] pop_str; wire pop_pulse_rd;
    always @(posedge rd_clk or posedge rst) begin
        if (rst) pop_str <= 3'd0;
        else if (pop_edge_rd) pop_str <= 3'd5;
        else if (pop_str != 0) pop_str <= pop_str - 3'd1;
    end
    assign pop_pulse_rd = (pop_str != 0);

    // FIFO instance
    wire [3:0] fifo_out;
    wire full, empty, data_valid;
    
    FIFO u_fifo (
        .WR_CLK    (wr_clk),
        .RD_CLK    (rd_clk),
        .rst       (rst),
        .push      (push_pulse_wr && !full),
        .pop       (pop_pulse_rd && !empty),
        .Data_In   (4'b0001),  // Simple constant data for testing
        .Data_Out  (fifo_out),
        .Full      (full),
        .Empty     (empty),
        .Data_Valid(data_valid)
    );

   
    
    wire [7:0] led_output;
    assign led_output = {
        ~pop_btn,       // LED7: Pop button pressed (ON when pressed)
        data_valid,     // LED6: Data valid from FIFO
        ~push_btn,      // LED5: Push button pressed (ON when pressed)
        full,           // LED4: FIFO full indicator
        1'b1,           // LED3: Always OFF (inverted)
        1'b1,           // LED2: Always OFF (inverted)  
        empty,          // LED1: FIFO empty indicator
        ~reset_btn      // LED0: Reset button pressed (ON when pressed)
    };
    
    assign leds = led_output;
    assign keypad_rows = 4'b1111;  // Disable keypad for now
endmodule