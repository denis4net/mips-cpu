`include "constants.v"
`include "periph_leds.v"

module leds_tb();

    reg clk;
    wire [8:0] leds;

    periph_leds periph_leds1(.clk(clk), .out(leds));

    initial begin
        clk = 0;
    end

    always begin
        #1 clk <= ~clk;
    end

    initial begin
        $dumpfile("leds_tb.vcd");
        $dumpvars(0, periph_leds1);

        $display("%8s %8s", "clk", "leds");
        #2 $monitor("%8b %8b", clk, leds);
        #50 $finish;
    end

endmodule
