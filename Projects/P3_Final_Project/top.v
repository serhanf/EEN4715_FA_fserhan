module top (
    input wire clk,
    input wire reset,
    input wire [3:0] switches,
    input wire [3:0] btn,
    output wire audio_out,
    output wire status_led,
    output wire [3:0] dig,
    output wire [7:0] seg
);
    wire slow_clk;

    clock_divider #(
        .DIVIDE_BY(6000000)
    ) u_clk_div (
        .clk_in(clk),
        .reset(reset),
        .clk_out(slow_clk)
    );

    assign status_led = slow_clk;

    reg [3:0] note_sel;
    always @* begin
        if (btn[0])       note_sel = 4'b0000; // C4
        else if (btn[1])  note_sel = 4'b0010; // E4
        else if (btn[2])  note_sel = 4'b0100; // G4
        else if (btn[3])  note_sel = 4'b0101; // A4
        else              note_sel = switches;
    end

    wire [31:0] period_value;

    tone_selector #(
        .CLOCK_FREQ(12000000)
    ) u_tone_sel (
        .note_sel(note_sel),
        .period_value(period_value)
    );

    pwm_gen u_pwm (
        .clk(clk),
        .reset(reset),
        .period(period_value),
        .pwm_out(audio_out)
    );

    display_driver_4digit u_disp (
        .clk(clk),
        .reset(reset),
        .value(note_sel),
        .dig(dig),
        .seg(seg)
    );
endmodule
