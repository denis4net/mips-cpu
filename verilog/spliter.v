/****************************************************************************
 * spliter.sv
 ****************************************************************************/

/**
 * Module: spliter
 *
 * Split address space to data memory space and IO address space
 */


module spliter(input wire [ADDR_WIDTH-1:0] addr, inout wire [DATA_WIDTH-1:0] data,
			   input wire read, input wire write, output wire ready,
			   //memory interface
			   output wire [ADDR_WIDTH-1:0] mem_addr, inout wire[DATA_WIDTH-1:0] mem_data,
			   output wire mem_read,  output wire mem_write,  input wire mem_ready,
				//io interface
			   output wire [ADDR_WIDTH-1:0] io_addr, inout wire[DATA_WIDTH-1:0] io_data,
			   output wire io_read, output wire io_write, input wire io_ready );

		parameter ADDR_WIDTH = 32;
		parameter DATA_WIDTH = 32;
		parameter ADDRESS_W = 32'hBFFFFFFF;		 //3G-1
		parameter IO_ADDRESS_DIFF = 32'hC0000000; //3G

		wire sel;
		reg [DATA_WIDTH-1:0] data_reg;

		assign sel = ( addr > ADDRESS_W ) ? 1'b1 : 1'b0; // 0 - memory controller, 1 - io controller

		assign io_data = (write & sel) ? data : 32'bz;
		assign io_addr = (addr - IO_ADDRESS_DIFF);
		assign io_read = (read & sel);
		assign io_write = (write & sel);

		assign mem_data = (write & ~sel) ? data : 32'bz;
		assign mem_addr = addr;
		assign mem_read = (read & ~sel);
		assign mem_write = (write & ~sel);
		assign data = (write) ? 32'bz : data_reg;
		assign ready = (sel) ? io_ready : mem_ready;

		always @(data, sel) begin
			data_reg = (sel) ? io_data : mem_data;
		end
endmodule

