`timescale 1ns/1ps

module FIFO_tb;
    
    reg WR_CLK = 0;
    reg RD_CLK = 0;
    
    
    reg rst;
    reg push;
    reg pop;
    reg [3:0] Data_In;
    
    // Outputs
    wire [3:0] Data_Out;
    wire Full;
    wire Empty;
    wire Data_Valid;
    
   
    always #10 WR_CLK = ~WR_CLK;  // 50MHz (20ns period)
    always #15 RD_CLK = ~RD_CLK;  // 33.3MHz (30ns period)
    
    
    FIFO uut (
        .WR_CLK(WR_CLK),
        .RD_CLK(RD_CLK),
        .rst(rst),
        .push(push),
        .pop(pop),
        .Data_In(Data_In),
        .Data_Out(Data_Out),
        .Full(Full),
        .Empty(Empty),
        .Data_Valid(Data_Valid)
    );
    
    initial begin
        $dumpfile("fifo_tb.vcd");
        $dumpvars(0, FIFO_tb);
        
       
        rst = 1;
        push = 0;
        pop = 0;
        Data_In = 4'h0;
        #100;
        
        // Release reset
        rst = 0;
        #100;
        
        // Test 1: Fill FIFO completely
        $display("=== Test 1: Filling FIFO ===");
        for (int i = 1; i <= 8; i++) begin
            Data_In = i;
            push = 1;
            @(posedge WR_CLK);
            #1;
            push = 0;
            @(posedge WR_CLK);
            $display("Pushed: %h, Full: %b", i, Full);
        end
        
        #100;
        
        // Test 2: Try to overflow
        $display("=== Test 2: Overflow Protection ===");
        Data_In = 4'hF;
        push = 1;
        @(posedge WR_CLK);
        push = 0;
        $display("After overflow attempt - Full: %b", Full);
        
        #100;
        
        // Test 3: Empty FIFO
        $display("=== Test 3: Emptying FIFO ===");
        for (int i = 0; i < 8; i++) begin
            pop = 1;
            @(posedge RD_CLK);
            #1;
            pop = 0;
            @(posedge RD_CLK);
            if (Data_Valid) 
                $display("Popped: %h, Empty: %b", Data_Out, Empty);
        end
        
        #100;
        
        // Test 4: Try underflow
        $display("=== Test 4: Underflow Protection ===");
        pop = 1;
        @(posedge RD_CLK);
        pop = 0;
        $display("After underflow attempt - Empty: %b", Empty);
        
        #200;
        $finish;
    end
endmodule