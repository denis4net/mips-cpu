`ifndef _ioslot
`define _ioslot

`include "constants.v"

module ioslot(
            //from address space splitter
            input read, input write, input [ADDR_WIDTH-1:0] addr,
            inout [DATA_WIDTH-1:0] data, output ready,
            //to io device
            output [PERIPH_ADDR_WIDTH-1:0] io_addr, inout [PERIPH_DATA_WIDTH-1:0] io_data,
            output io_read, output io_write, input io_ready);

    parameter ADDR_WIDTH = `IO_ADDR_WIDTH;
    parameter DATA_WIDTH = `IO_DATA_WIDTH;

    parameter ADDR_SPACE_SIZE = `PERIPH_REGISTERS_COUNT;
    parameter ADDR_START = 32'b0;  //must be specified at module instatiate
    parameter PERIPH_DATA_WIDTH = `PERIPH_DATA_WIDTH;
    parameter PERIPH_ADDR_WIDTH = `PERIPH_ADDR_WIDTH; //ln(ADDR_SPACE_SIZE)

    wire end_addr;
    wire is_current_device;

    assign end_addr = (ADDR_START + ADDR_SPACE_SIZE);
    assign is_current_device = (addr >= ADDR_START & addr < end_addr);
    //assign data buses
    assign io_data = (read) ? {(PERIPH_DATA_WIDTH){1'bz}} : data;
    assign data = (read) ? io_data : {(DATA_WIDTH){1'bz}};
    //assgin  address busses
    assign io_addr = (io_read | io_write) ? addr - ADDR_START : {(PERIPH_DATA_WIDTH){1'bz}};
    //assign control wires
    assign io_read  = (read &  is_current_device);
    assign io_write = (write & is_current_device);
endmodule
`endif