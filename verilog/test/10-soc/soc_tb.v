`include "soc.v"
`include "constants.v"

module soc_tb();

    reg clk;
    wire [8:0] leds;
    reg [7:0] buttons;

    soc soc1(.g_clk(clk), .g_leds(leds), .g_buttons(buttons));

    clkdiv #(.CLK_DIVIDER_WIDTH(4), .CLK_DIVIDER_VALUE(4'd2)) clkdiv1(.in(clk), .out(out));

    initial begin
        buttons = 8'b0;
    end

    initial begin
        clk = 0;
        $dumpfile("soc_tb.vcd");
        $dumpvars(0, soc1);

        $display("%8s %8s", "leds", "buttons");
        #2 $monitor("%8b %8b", leds, buttons);
        #100 $finish;
    end

    always begin
        #1 clk <= ~clk;
    end

endmodule