`timescale 1ns / 1ps

module TB_ALU;
    reg [2:0] op;
    reg [15:0] result;
    reg [15:0] operand_1;
    reg [15:0] operand_2;

    alu_bus bus(.op(op), .result(result), .operand_1(operand_1), .operand_2(operand_2));
    alu alu(bus);

    initial begin
        op <= 'b0;
        result <= 'b0;
        operand_1 <= 'b1;
        operand_2 <= 'b1;

        #10 op <= 'b1;
        if (bus.result != 'b10)
            $display("Add incorrect");

        #10 op <= 'b10;
        if (bus.result != 'b0)
            $display("Sub incorrect");

        #10 operand_1 <= 'b10;
            operand_2 = 'b10; 
            op <= 'b11;
        if (bus.result != 'b100)
            $display("Multiply incorrect");

        #10 operand_1 <= 'b100;
            operand_2 = 'b10;
            op <= 'b100;
        if (bus.result != 'b10)
            $display("Division incorrect");

        #10 operand_1 <= 'b101; 
            operand_2 = 'b100;
            op <= 'b101;
        if (bus.result != 'b100)
            $display("AND incorrect");

        #10 op <= 'b110;
        if (bus.result != 'b101)
            $display("OR incorrect");

        #10 operand_1 = 'hAAAA;
            op <= 'b111;
        if (bus.result != 'h5555)
            $display("NOT incorrect");
    end
endmodule
