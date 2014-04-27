`include "ioslot.v"

module spliter_tb();

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 32;

    reg clk;
    wire [DATA_WIDTH-1:0] data;
    wire [ADDR_WIDTH-1:0] addr;
    wire read, write, ready;

    wire [31:0] io_data;
    wire [5:0] io_addr;
    wire io_read, io_write, io_ready;

    ioslot #( .ADDR_START(32'h40) ) ioslot1(.data(data), .addr(addr), .read(read), .write(write), .ready(ready),
            .io_data(io_data), .io_addr(io_addr), .io_ready(io_ready), .io_read(io_read), .io_write(io_write) );


    reg [DATA_WIDTH-1:0] data_reg, io_data_reg, mem_data_reg;
    reg [ADDR_WIDTH-1:0] addr_reg, io_addr_reg, mem_addr_reg;
    reg read_reg, write_reg;

    assign data = (read) ?  32'bz : data_reg;
    assign addr = addr_reg;
    assign read = read_reg;
    assign write = write_reg;
    assign io_data = (io_read) ?  32'bz : io_data_reg;

    always begin
        clk <= ~clk;
        #10;
    end

    initial begin
        $dumpfile("ioslot_tb.vcd");
        $dumpvars(0, ioslot1);

        $display("%8s %8s %8s %8s %8s %8s %8s %8s", "addr", "data", "r", "w", "io_data", "io_addr", "io_read",  "io_write");
        $monitor("%8x %8x %8x %8x %8x %8x %8x %8x", addr, data, read, write, io_data, io_addr, io_read, io_write);

        clk <= 1'b0;
        addr_reg <= 32'h3F;
        data_reg <= 32'b0;
        read_reg <= 1'b0;
        write_reg <= 1'b0;

        @(posedge clk);
        addr_reg <= 32'h40;
        data_reg <= 32'h80;
        write_reg <= 1'b0;
        read_reg <= 1'b0;

        @(posedge clk);
        addr_reg <= 32'h41;
        data_reg <= 32'h80;
        write_reg <= 1;
        read_reg <= 0;

        @(posedge clk);
        addr_reg <= 32'h42;
        data_reg <= 32'h80;
        write_reg <= 0;
        read_reg <= 1;
        mem_data_reg <= 32'h50;

        @(posedge clk);
        addr_reg <= 32'hC0000000;
        data_reg <= 32'h80;
        write_reg <= 1'b1;
        read_reg <= 1'b0;

        @(posedge clk);
        addr_reg <= 32'hC0000001;
        data_reg <= 32'h80;
        write_reg <= 1'b1;
        read_reg <= 1'b0;

        @(posedge clk);
        addr_reg <= 32'h5F;
        data_reg <= 32'h80;
        write_reg <= 0;
        read_reg <= 1;
        io_data_reg <= 32'h500;

        $finish;
    end
endmodule
