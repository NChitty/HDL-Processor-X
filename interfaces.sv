interface register_bus;
    logic [2:0] rs1;
    logic [2:0] rs2;
    logic [2:0] rd;
    logic [15:0] data_in;
    logic we;
    logic [15:0] data_rs1;
    logic [15:0] data_rs2;
endinterface

interface alu_bus;
    logic [2:0] op;
    logic [15:0] result;
    logic [15:0] operand_1;
    logic [15:0] operand_2;
endinterface
