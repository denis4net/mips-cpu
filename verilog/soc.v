`ifndef _soc
`define _soc

`include "cpu.v"
`include "spliter.v"
`include "dm.v"
`include "ioctrl.v"
`include "iobus.v"
`include "constants.v"
`include "clkdiv.v"

/*
 * altera cyclone III fpga platform specific code
 */
module soc(input wire g_clk, output wire [8:0] g_leds,
	output wire[11:0] g_display, input wire [7:0] g_buttons
`ifdef DEBUG //in case, if perfoming simulation on computer
		,
		output wire [31:0]	if_pc,		// program counter (PC)
		output wire [31:0]	if_instr,	// instruction read from memory (IM)

		output wire [31:0]	id_regrs,
		output wire [31:0]	id_regrt,

		output wire [31:0]	ex_alua,
		output wire [31:0]	ex_alub,
		output wire [3:0]	ex_aluctl,

		output wire 		cpu_ready,
		output wire [31:0]	cpu_data,
		output wire [31:0] 	cpu_addr,
		output wire			cpu_read,
		output wire			cpu_write,

		output wire [31:0]	wb_regdata,
		output wire 		wb_regwrite
`endif
	);

	parameter CPU_ADDR_WIDTH = `CPU_ADDR_WIDTH;
	parameter CPU_DATA_WIDTH = `CPU_DATA_WIDTH;

	parameter MEM_ADDR_WIDTH = `MEM_ADDR_WIDTH;
	parameter MEM_DATA_WIDTH = `MEM_DATA_WIDTH;

	parameter IO_ADDR_WIDTH = `IO_ADDR_WIDTH;
	parameter IO_DATA_WIDTH = `IO_DATA_WIDTH;

	wire [CPU_DATA_WIDTH-1:0] data;
	wire [CPU_ADDR_WIDTH-1:0] addr;
	wire read, write, ready;
	wire clk;

	`ifdef DEBUG
	assign clk = g_clk;

	cpu cpu1(.clk(clk), .mem_memdata(data), .mem_addr(addr),
			.mem_memread(read), .mem_memwrite(write), .mem_ready(ready),
			.if_pc(if_pc), .if_instr(if_instr),
			.id_regrs(id_regrs), .id_regrt(id_regrt),
			.ex_alua(ex_alua), .ex_alub(ex_alub), .ex_aluctl(ex_aluctl),
			.wb_regwrite(wb_regwrite), .wb_regdata(wb_regdata)
			);

	`else
	clkdiv #(.CLK_DIVIDER_VALUE(26'd5000000)) div1(.in(g_clk), .out(clk));
	cpu cpu1(.clk(clk), .mem_memdata(data), .mem_addr(addr),
			.mem_memread(read), .mem_memwrite(write), .mem_ready(ready),
			);
	`endif

	`ifdef DEBUG
		//connect debug wires
		assign cpu_write = write;
		assign cpu_read = read;
		assign cpu_addr = addr;
		assign cpu_data = data;
		assign cpu_ready = ready;
	`endif

	//attaching address space splitter
	wire [MEM_DATA_WIDTH-1:0] mem_data;
	wire [MEM_ADDR_WIDTH-1:0] mem_addr;
	wire mem_read, mem_write, mem_ready;

	wire [IO_DATA_WIDTH-1:0] io_data;
	wire [IO_ADDR_WIDTH-1:0] io_addr;
	wire io_read, io_write, io_ready;

	spliter addr_splitter1(.addr(addr), .data(data), .read(read), .write(write), .ready(ready),
							.mem_addr(mem_addr), .mem_data(mem_data), .mem_read(mem_read),
							.mem_write(mem_write), .mem_ready(mem_ready),
							.io_addr(io_addr), .io_data(io_data), .io_read(io_read),
							.io_write(io_write), .io_ready(io_ready) );

	//attaching memory busses to address splitter
	wire mem_clk;
	assign mem_clk = g_clk;
	dm dm1(.clk(mem_clk),.rd(mem_read), .wr(mem_write), .ready(mem_ready),
			.data(mem_data), .addr(mem_addr) );


	//attachin IO controller
	wire io_clk;
	assign io_clk = g_clk;

	wire [IO_DATA_WIDTH-1:0] iobus_addr;
	wire [IO_ADDR_WIDTH-1:0] iobus_data;
	wire iobus_read, iobus_write, iobus_ready;
	wire iobus_clk;
	ioctrl ioctrl1(.addr(io_addr), .data(io_data), .read(io_read), .write(io_write), .ready(io_ready),
		.io_addr(iobus_addr), .io_data(iobus_data), .io_read(iobus_read), .io_write(iobus_write), .io_ready(iobus_ready)
		);

	clkdiv #(.CLK_DIVIDER_VALUE(26'd125000)) div2(.in(g_clk), .out(iobus_clk));

	iobus iobus1(.clk(iobus_clk), .addr(iobus_addr), .data(iobus_data), .read(iobus_read), .write(iobus_write),
		.ready(iobus_ready),
		`ifdef LEDS
			.leds(g_leds),
		`endif
		`ifdef DISPLAY
			.display(g_display)
		`endif
		`ifdef BUTTONS
		 , .buttons(g_buttons)
		`endif
		);
	assign g_leds[8] = clk;

endmodule

`endif