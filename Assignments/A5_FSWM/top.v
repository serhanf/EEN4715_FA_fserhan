// Fadi Serhan
// Project 1 - Washing Machine 

module top (
    input  wire clk,
    input  wire rst_n,            // reset

    // Switches / buttons
    input  wire sw0, sw1,         // load size (SW1 SW0)
    input  wire sw2, sw3,         // temp (SW3 SW2)
    input  wire sw4,              // second rinse
    input  wire sw5,              // extra spin
    input  wire sw6,              // lid (0=closed, 1=open)
    input  wire start_btn,        // start



    output reg  [5:0] led,        // 3 bits state + 3 bits seconds (LSBs)
    output reg  [7:0] sevenseg,   // 7-seg shows state number (0..6) (active-low)
    output wire rinse2,           
    output wire spin2             
);



    parameter COUNT_WIDTH = 24;
    parameter [COUNT_WIDTH-1:0] COUNT = 16_000_000-1;  

    reg [COUNT_WIDTH:0] count;
    reg tick_1hz;  // 1-cycle pulse each second




    localparam S_OFF        = 3'd0;
    localparam S_FILL       = 3'd1;
    localparam S_WASH       = 3'd2;
    localparam S_RINSE      = 3'd3;
    localparam S_RINSE2     = 3'd4;
    localparam S_SPIN       = 3'd5;
    localparam S_EXTRA_SPIN = 3'd6;

    reg [2:0] state, next;

 


    // Load size (SW1 SW0)
    wire load_small   = (~sw1 & ~sw0);   // 00
    wire load_medium  = (~sw1 &  sw0);   // 01
    wire load_large   = ( sw1 & ~sw0);   // 10
    wire load_invalid = ( sw1 &  sw0);   // 11

    // Temp (SW3 SW2)
    wire temp_hot     = (~sw3 & ~sw2);   // 00
    wire temp_warm    = (~sw3 &  sw2);   // 01
    wire temp_cold    = ( sw3 & ~sw2);   // 10
    wire temp_invalid = ( sw3 &  sw2);   // 11

    


    assign rinse2 = sw4;
    assign spin2  = sw5;

    wire lid_closed = (sw6 == 1'b0);

    // Dwell time per state (seconds)
    wire [3:0] dwell_s =
        load_small  ? 4'd3 :
        load_medium ? 4'd5 :
        load_large  ? 4'd8 : 4'd0;

    // Start condition
    wire can_start = start_btn & lid_closed & ~load_invalid & ~temp_invalid & (dwell_s != 0);




    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            count    <= { (COUNT_WIDTH+1){1'b0} };
            tick_1hz <= 1'b0;
        end else if (count == COUNT) begin
            count    <= { (COUNT_WIDTH+1){1'b0} };
            tick_1hz <= 1'b1;
        end else begin
            count    <= count + {{COUNT_WIDTH{1'b0}}, 1'b1};
            tick_1hz <= 1'b0;
        end
    end



    reg [5:0] sec_cnt;
    wire      sec_done = tick_1hz && (sec_cnt == dwell_s);

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) begin
            sec_cnt <= 6'd0;
        end else if (state == S_OFF) begin
            sec_cnt <= 6'd0;
        end else if (tick_1hz) begin
            if (sec_cnt == dwell_s) sec_cnt <= 6'd0;
            else                    sec_cnt <= sec_cnt + 6'd1;
        end
    end

 

    always @(posedge clk or posedge rst_n) begin
        if (rst_n) state <= S_OFF;
        else        state <= next;
    end


    always @* begin
        next = state;
        case (state)
            S_OFF:        if (can_start) next = S_FILL;
            S_FILL:       if (sec_done)  next = S_WASH;
            S_WASH:       if (sec_done)  next = S_RINSE;
            S_RINSE:      if (sec_done)  next = (sw4 ? S_RINSE2 : S_SPIN);
            S_RINSE2:     if (sec_done)  next = S_SPIN;
            S_SPIN:       if (sec_done)  next = (sw5 ? S_EXTRA_SPIN : S_OFF);
            S_EXTRA_SPIN: if (sec_done)  next = S_OFF;
            default:                    next = S_OFF;
        endcase
    end

    
    // LEDs: show state (3 bits) + seconds LSBs (3 bits)
   
    always @* begin
        led[2:0] = state;           // state on lower 3 LEDs
        led[5:3] = sec_cnt[2:0];    // seconds counter (LSBs) on upper 3 LEDs
    end

    

    // Seven-seg shows the state number 0..6 
  
    always @* begin
        case (state)
            3'd0: sevenseg = 8'b1100_0000; // 0
            3'd1: sevenseg = 8'b1111_1001; // 1
            3'd2: sevenseg = 8'b1010_0100; // 2
            3'd3: sevenseg = 8'b1011_0000; // 3
            3'd4: sevenseg = 8'b1001_1001; // 4
            3'd5: sevenseg = 8'b1001_0010; // 5
            3'd6: sevenseg = 8'b1000_0010; // 6
            default: sevenseg = 8'b1111_1111; // blank/off
        endcase
    end

endmodule
