
`define DEBUG

`include "soc.v"
`include "constants.v"

module soc_tb();
    reg [8:0] i;
    reg clk;
    wire [8:0] leds;
    wire [11:0] display;
    reg [7:0] buttons;

    wire [31:0]  if_pc;      // program counter (PC)
    wire [31:0]  if_instr;   // instruction read from memory (IM)

    wire [31:0]  id_regrs;
    wire [31:0]  id_regrt;

    wire [31:0]  ex_alua;
    wire [31:0]  ex_alub;
    wire [3:0]   ex_aluctl;

    wire         cpu_ready;
    wire [31:0]  cpu_data;
    wire [31:0]  cpu_addr;
    wire         cpu_read;
    wire         cpu_write;

    wire [31:0]  wb_regdata;
    wire         wb_regwrite;

    soc soc1(.g_clk(clk), .g_leds(leds), .g_buttons(buttons), .g_display(display),
            .if_pc(if_pc), .if_instr(if_instr), .id_regrs(id_regrs), .id_regrt(id_regrt),
            .ex_alua(ex_alua), .ex_alub(ex_alub), .ex_aluctl(ex_aluctl),
            .cpu_write(cpu_write), .cpu_read(cpu_read), .cpu_addr(cpu_addr),
            .cpu_data(cpu_data), .cpu_ready(cpu_ready),
            .wb_regdata(wb_regdata), .wb_regwrite(wb_regwrite)
        );

    initial begin
        buttons = 8'b0;
    end

    initial begin
        clk = 0;
        $dumpfile("soc_tb.vcd");
        $dumpvars(0, soc1);

        $display("%8s %8s %8s %8s %8s| %8s %8s| %4s %11s",
            "cpu_addr", "cpu_data", "cpu_read", "cpu_write", "cpu_ready",
            "wb_regd", "wb_regwr",
            "leds", "disp");

        $monitor("%8X %8X %8X %8X %8X| %8x %8x| %4x %11b",
            cpu_addr, cpu_data, cpu_read, cpu_write, cpu_ready,
            wb_regdata, wb_regwrite,
            leds[6:0],
            display);

        #50 $display("rg| value");

        for (i = 1; i < 32; i = i + 1)
        begin
            $display("%2d| %8x", i, soc1.cpu1.regm1.mem[i]);
        end
/*
        //dumping Data memory
        $display("Data memory");
        $display("    | %8x %8x %8x %8x", 0, 4, 8, 12);
        for(i = 0; i < 48; i = i + 4)
        begin
            $display("%4x| %8x %8x %8x %8x", i*4, soc1.dm1.mem[i],
                soc1.dm1.mem[i+1], soc1.dm1.mem[i+2], soc1.dm1.mem[i+3]);
        end
*/
        //dumping IO device configuration registers
        `ifdef LEDS
        $display("Led registers");
        $display("    | %8x %8x %8x %8x", 0, 4, 8, 12);
        for(i = 0; i < 8; i = i + 4)
        begin
            $display("%4x| %8x %8x %8x %8x", i*4, soc1.iobus1.periph_leds1.registers[i],
                soc1.iobus1.periph_leds1.registers[i+1], soc1.iobus1.periph_leds1.registers[i+2],
                soc1.iobus1.periph_leds1.registers[i+3]);
        end
        `endif

        `ifdef DISPLAY
        $display("Display registers");
        $display("    | %8x %8x %8x %8x", 0, 4, 8, 12);
        for(i = 0; i < 8; i = i + 4)
        begin
            $display("%4x| %8x %8x %8x %8x", i*4, soc1.iobus1.display1.registers[i],
                soc1.iobus1.display1.registers[i+1], soc1.iobus1.display1.registers[i+2],
                soc1.iobus1.display1.registers[i+3]);
        end
        `endif

        $finish;
    end

    always begin
        #1 clk <= ~clk;
    end

endmodule
