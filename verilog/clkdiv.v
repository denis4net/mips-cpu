`include "constants.v"

`ifndef _clkdiv
`define _clkdiv

module clkdiv(input in, output out);

    parameter CLK_DIVIDER_WIDTH = `CLK_DIVIDER_WIDTH;
    parameter CLK_DIVIDER_VALUE = `CLK_DIVIDER_VALUE;

    reg [CLK_DIVIDER_WIDTH-1:0] _icounter;
    reg _internal_clk;

    assign out = _internal_clk;


    initial begin
        _icounter = {(CLK_DIVIDER_WIDTH){1'b0}};
        _internal_clk = 0;
    end

    always @(posedge in) begin
        _internal_clk =  (_icounter == {CLK_DIVIDER_VALUE} ) ? ~_internal_clk : _internal_clk;
        _icounter = (_icounter == {CLK_DIVIDER_VALUE} ) ? 0 : _icounter + 1;
    end

endmodule

`endif