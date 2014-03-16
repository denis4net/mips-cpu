`ifndef _soc
`define _soc
/*
 * altera cyclone III fpga platform specific code
 */

module soc(input wire clk, output wire status_led);

	parameter CLOCK_DIV_WIDTH = 25; //with of register for clock divider
	parameter ADDR_WIDTH = 32;
	parameter DATA_WIDTH = 32;

	wire [DATA_WIDTH-1:0] data;
	wire [ADDR_WIDTH-1:0] addr;
	wire read, write, ready;

	cpu cpu1(.clk(clk), .mem_memdata(data), .mem_addr(addr),
			.mem_memread(read), .mem_memwrite(write), .mem_ready(ready));

	//attaching address space splitter
	wire [DATA_WIDTH-1:0] mem_data;
	wire [ADDR_WIDTH-1:0] mem_addr;
	wire mem_read, mem_write, mem_ready;

	wire [DATA_WIDTH-1:0] io_data;
	wire [ADDR_WIDTH-1:0] io_addr;
	wire io_read, io_write, io_ready;

	spliter addr_splitter1(.addr(addr), .data(data), .read(read), .write(write),
							.mem_addr(mem_addr), .mem_data(mem_data), .mem_read(mem_read),
							.mem_write(mem_write), .mem_ready(mem_ready),
							.io_addr(io_addr), .io_data(io_data), .io_read(io_read),
							.io_write(io_write), .io_ready(io_ready) );

	//attaching data memory
	wire mem_clk;
	assign mem_clk = clk;
	dm dm1(.clk(mem_clk),.rd(mem_read), .wr(mem_write), .ready(mem_ready),
			.data(mem_data), .addr(mem_addr) );


	//attachin IO controller
endmodule

`endif