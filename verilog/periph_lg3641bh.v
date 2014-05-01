`ifndef _periph_lg3641bh
`define _periph_lg3641bh

`include "constants.v"

module periph_lg3641bh (
        input clk,
        input [ADDR_WIDTH-1:0] addr,
        inout [DATA_WIDTH-1:0] data,
        input read,
        input write,
        output ready,
        output [11:0] out
    );

    parameter DATA_WIDTH = `PERIPH_DATA_WIDTH;
    parameter ADDR_WIDTH = `PERIPH_ADDR_WIDTH;
    parameter PERIPH_ADDR_SPACE_SIZE = `PERIPH_REGISTERS_COUNT;

    /* peripheral device memory map
        register[0] - device type/class
        register[1] - device pid/vid
        register[2] - global configuration register
        register[3] - global status register
    */

    /*
        PINS    FPGA  SECTION
        1       224     E
        2       221     D
        3       226     DP
        4       219     C
        5       230     G
        6               DIG.4
        7       217     B
        8               DIG3
        9               DIG4
        10      223     F
        11      218     A
        12              DIG.1
    */
    reg [PERIPH_ADDR_SPACE_SIZE-1:0] registers[DATA_WIDTH-1:0];
    reg [DATA_WIDTH-1:0] data_r;
    reg [11:0] out_r;

    reg [2:0] i;


    initial begin
        registers[0] = {(DATA_WIDTH){1'h1}};
        registers[1] = {(DATA_WIDTH){1'h1}};
        registers[2] = {(DATA_WIDTH){1'h0}};
        /* configuration registers */
        registers[3] = {(DATA_WIDTH){1'h1}}; //global configuration
        registers[4] = {(DATA_WIDTH){1'h0}}; //dig1
        registers[5] = {(DATA_WIDTH){1'h0}}; //dig2
        registers[6] = {(DATA_WIDTH){1'h0}}; //dig3
        registers[7] = {(DATA_WIDTH){1'h0}}; //dig4
    end

    assign ready = write | read;
    assign data = ( write | ~read ) ? {(DATA_WIDTH){1'bz}} : data_r;

    wire [3:0] enabled;
    assign enabled = registers[3][3:0];

    assign out = out_r;

    always @(posedge clk)
        registers[addr] = write ? data : registers[addr];

    reg [7:0] code; // { DP, G, F, E, D, C, B, A}

    /*
        PINS    FPGA  SECTION
        0 1       224     E
        1 2       221     D
        2 3       226     DP
        3 4       219     C
        4 5       230     G
        5 6               DIG.4
        6 7       217     B
        7 8               DIG3
        8 9               DIG4
        9 10      223     F
        10 11     218     A
        11 12              DIG.1
    */
    //   7   6  5  4  3  2  1  0
    // { DP, G, F, E, D, C, B, A}
    initial
        i = 0;

    always @(posedge clk) begin
            out_r = { ~(i==0), code[0], code[5], ~(i==1), ~(i==2),  code[1], ~(i==3),
                code[6], code[2], code[7], code[3], code[4]};

            i = ( (i+1) < 4'd4) ? i+1 : 4'd0;
    end

    always @(negedge clk) begin
        case (registers[4+i])
                            /*  DP   G      F     E     D     C     B     A  */
                4'h0: code = {1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
                4'h1: code = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1};
                4'h2: code = {1'b1, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0};
                4'h3: code = {1'b1, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
                4'h4: code = {1'b1, 1'b0, 1'b0, 1'b1, 1'b1, 1'b0, 1'b0, 1'b1};
                4'h5: code = {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b1, 1'b0};
                4'h6: code = {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b1, 1'b0};
                4'h7: code = {1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b0, 1'b0};
                4'h8: code = {1'b1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0};
                4'h9: code = {1'b1, 1'b0, 1'b0, 1'b1, 1'b0, 1'b0, 1'b0, 1'b0};
                default: code = {1'b0, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1};
            endcase
    end

endmodule

`endif
