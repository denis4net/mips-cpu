`ifndef _iobus
`define _iobus

`include "constants.v"
`include "ioslot.v"
`include "periph_leds.v"

module iobus(
            input wire clk,
            //from address space splitter
            input read, input write, input [IO_ADDR_WIDTH-1:0] addr,
            inout [IO_DATA_WIDTH-1:0] data, output ready,
            //to io device
            output wire [8:0] leds, input wire [7:0] buttons);

    parameter IO_ADDR_WIDTH = `IO_ADDR_WIDTH;
    parameter IO_DATA_WIDTH = `IO_DATA_WIDTH;

    parameter PERIPH_DATA_WIDTH = `PERIPH_DATA_WIDTH;
    parameter PERIPH_ADDR_WIDTH = `PERIPH_ADDR_WIDTH;

    wire [PERIPH_ADDR_WIDTH-1:0] leds_addr;
    wire [PERIPH_DATA_WIDTH-1:0] leds_data;
    wire leds_ready, leds_write, leds_read;

    ioslot #(.ADDR_START(8'h80)) leds_lslot(.data(data), .addr(addr), .read(read), .write(write), .ready(ready),
        .io_data(leds_data), .io_addr(leds_addr), .io_ready(leds_ready),
        .io_write(leds_write), .io_read(leds_read));

    periph_leds periph_leds1(.clk(clk), .data(leds_data), .addr(leds_addr), .ready(leds_ready),
        .read(leds_read), .write(leds_write), .out(leds));

endmodule

`endif