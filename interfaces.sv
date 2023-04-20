interface if_id;
    logic clk;
    logic we;
    logic [13:0] pc_in;
    logic [15:0] instr;
endinterface

interface id_ex;
    logic clk;
    logic nop;
    logic lu;
    logic [1:0] mem_fn;
    logic [2:0] rd;
    logic [1:0] fn;
    logic [15:0] rs1;
    logic [15:0] rs2;
    logic [15:0] data;
    logic we;
endinterface

interface ex_mem;
    logic clk;
    logic [2:0] rd;
    logic [15:0] rs1;
    logic [1:0] fn;
endinterface

interface register_bus;
    logic [2:0] rs1;
    logic [2:0] rs2;
    logic [2:0] rd;
    logic [15:0] data_in;
    logic we;
    logic [15:0] data_rs1;
    logic [15:0] data_rs2;
endinterface