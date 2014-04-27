
`define DEBUG

`include "soc.v"
`include "constants.v"

module soc_tb();

    reg clk;
    wire [8:0] leds;
    reg [7:0] buttons;

    wire [31:0]  if_pc;      // program counter (PC)
    wire [31:0]  if_instr;   // instruction read from memory (IM)

    wire [31:0]  id_regrs;
    wire [31:0]  id_regrt;

    wire [31:0]  ex_alua;
    wire [31:0]  ex_alub;
    wire [3:0]   ex_aluctl;

    wire         mem_memready;
    wire [31:0]  mem_memdata;
    wire [31:0]  mem_memaddr;
    wire         mem_memread;
    wire         mem_memwrite;

    wire [31:0]  wb_regdata;
    wire         wb_regwrite;

    soc soc1(.g_clk(clk), .g_leds(leds), .g_buttons(buttons),
            .if_pc(if_pc), .if_instr(if_instr), .id_regrs(id_regrs), .id_regrt(id_regrt),
            .ex_alua(ex_alua), .ex_alub(ex_alub), .ex_aluctl(ex_aluctl),
            .mem_memwrite(mem_memwrite), .mem_memread(mem_memread), .mem_memaddr(mem_memaddr),
            .mem_memdata(mem_memdata), .mem_memready(mem_memready),
            .wb_regdata(wb_regdata), .wb_regwrite(wb_regwrite)
        );

    initial begin
        buttons = 8'b0;
    end

    initial begin
        clk = 0;
        $dumpfile("soc_tb.vcd");
        $dumpvars(0, soc1);

        $display("%8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s %8s",
            "leds",
            "if_pc", "if_instr",
            "id_regrs", "id_regrs", "ex_alua", "ex_alub", "ex_aluctl",
            "mem_addr", "mem_memdata", "mem_memread", "mem_memwrite", "mem_memready");

        $monitor("%8X %8X %8X %8X %8X %8X %8X %8X %8X %8X %8X %8X %8X",
            leds,
            if_pc, if_instr,
            id_regrs, id_regrs, ex_alua, ex_alub, ex_aluctl,
            mem_memaddr, mem_memdata, mem_memread, mem_memwrite, mem_memready);

        #200 $finish;
    end

    always begin
        #1 clk <= ~clk;
    end

endmodule