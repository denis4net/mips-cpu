`include "clkdiv.v"

module clkdiv_tb();
    reg clk;
    wire out;

    clkdiv #(.CLK_DIVIDER_WIDTH(4), .CLK_DIVIDER_VALUE(4'd2)) clkdiv1(.in(clk), .out(out));

    initial begin
        clk = 0;
        $dumpfile("clkdiv_tb.vcd");
        $dumpvars(0, clkdiv1);

        $display("%8s %8s", "in", "out");
        #2 $monitor("%8x %8x", clk, out);
        #20 $finish;
    end


    always begin
        #1 clk <= ~clk;
    end

endmodule