`ifndef _periph_leds
`define _periph_leds

`include "constants.v"

module periph_leds (
        input clk,
        input [ADDR_WIDTH-1:0] addr,
        inout [DATA_WIDTH-1:0] data,
        input read,
        input write,
        output ready,
        output [8:0] out //control 9 leds
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
        led specific register fields
        TODO:
    */
    reg [PERIPH_ADDR_SPACE_SIZE-1:0] registers[DATA_WIDTH-1:0];
    reg [DATA_WIDTH-1:0] data_r;

    initial begin
        registers[0] = {(DATA_WIDTH){1'h1}};
        registers[1] = {(DATA_WIDTH){1'h1}};
        registers[2] = {(DATA_WIDTH){1'h0}};
        registers[3] = {(DATA_WIDTH){1'h1}};
    end

    assign ready = write | read;
    assign data = write | ~read ? {(DATA_WIDTH){1'bz}} : data_r;
    assign out[7:0] = ( registers[3][DATA_WIDTH-1] ? registers[3][7:0] : 7'h0);
    assign out[8] = clk;

    always @(*)
        registers[addr] = write ? data : registers[addr];


endmodule

`endif
