`ifndef _constants
`define _constants

`define CPU_DATA_WIDTH 32
`define CPU_ADDR_WIDTH 32

`define MEM_DATA_WIDTH 32
`define MEM_ADDR_WIDTH 32

`define IO_DATA_WIDTH 32
`define IO_ADDR_WIDTH 32
`define IO_ADDR_DIFF 32'hC0000000

`define PERIPH_DATA_WIDTH 32
`define PERIPH_ADDR_WIDTH 6
`define PERIPH_REGISTERS_COUNT 32 //count of peripheral registers on peripheral device

`define CLK_DIVIDER_WIDTH 26
`define CLK_DIVIDER_VALUE 26'd30000000

`define NMEM 128 //instruction memory in 32bit words
`define IM_DATA "im_data.hex" //path to instruction memory init file

`define DISPLAY

`endif