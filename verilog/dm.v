/*
 * Data Memory.
 *
 * 32-bit data with a 7 bit address (128 entries).
 *
 * The read and write operations operate somewhat independently.
 *
 * Any time the read signal (rd) is high the data stored at the
 * given address (addr) will be placed on 'rdata'.
 *
 * Any time the write signal (wr) is high the data on 'wdata' will
 * be stored at the given address (addr).
 * 
 * If a simultaneous read/write is performed the data written
 * can be immediately read out.
 */

`ifndef _dm
`define _dm

module dm(
		input wire			clk,
		input wire	[31:0]	addr,
		input wire			rd, wr,
		inout wire [31:0] data, 
		output reg ready);

	reg [31:0] mem [0:127];  // 32-bit memory with 128 entries

	always @(posedge clk) begin
		if (wr) begin
			mem[addr[8:2]] <= data;
			ready <= 1;
		end
		else if (rd)
			ready <= 1;
		else
			ready <= 0;
	end

	// During a write, avoid the one cycle delay by reading from 'wdata'
	assign data = wr ? 32'bz : mem[addr[8:2]][31:0];

endmodule

`endif
