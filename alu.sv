`timescale 1ns / 1ps

module alu ( alu_bus bus );

    always @(bus.op, bus.operand_1, bus.operand_2) begin
        case (bus.op)
            'b001: bus.result <= bus.operand_1 + bus.operand_2;
            'b010: bus.result <= bus.operand_1 - bus.operand_2;
            'b011: bus.result <= bus.operand_1 * bus.operand_2;
            'b100: bus.result <= bus.operand_1 / bus.operand_2;
            'b101: bus.result <= bus.operand_1 & bus.operand_2;
            'b110: bus.result <= bus.operand_1 | bus.operand_2;
            'b111: bus.result <= ~bus.operand_1; 
        endcase
    end
endmodule