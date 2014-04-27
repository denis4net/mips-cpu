
`ifndef _ioctrl
`define _ioctrl

`include "constants.v"
`include "ioslot.v"


/*
 * IO Controller for peripheral bus control
 */
module ioctrl(input wire [ADDR_WIDTH-1:0] addr, inout wire [DATA_WIDTH-1:0] data, input read, input write, output ready,
     output wire [ADDR_WIDTH-1:0] io_addr, inout wire [DATA_WIDTH-1:0] io_data, output io_read, output io_write, input io_ready);

    parameter ADDR_WIDTH = `IO_ADDR_WIDTH;
    parameter DATA_WIDTH = `IO_DATA_WIDTH;

    assign io_addr = addr;
    assign io_data = (write) ? data : {(DATA_WIDTH){1'bz}};
    assign data = (read) ? io_data : {(DATA_WIDTH){1'bz}};

    assign io_read = read;
    assign io_write = write;
    assign ready = io_ready;

endmodule

`endif