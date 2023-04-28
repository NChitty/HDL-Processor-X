`timescale 1ns / 1ps

module TB_REG;
    reg [2:0] rs1;
    reg [2:0] rs2;
    reg [2:0] rd;
    reg [15:0] data_in;
    reg we;
    reg [15:0] data_rs1;
    reg [15:0] data_rs2;

    register_bus bus(.rs1(rs1), .rs2(rs2), .rd(rd), .data_in(data_in), .we(we), .data_rs1(data_rs1), .data_rs2(data_rs1));

    registers regs(bus);

    initial begin
        rs1 <= 3'b0;
        rs2 <= 3'b0;
        rd <= 3'b0;
        data_in <= 'h0000;
        we <= 1'b0;
        data_rs1 <= 'h0000;
        data_rs2 <= 'h0000;

        #10 we <= 1'b1;
            data_in <= 'hAAAA
        #10 we <= 1'b0;
            rs1 <= 3'b111;
        #1  rs1 <= 3b'000;
       if (data_rs1 != 'hAAAA) 
            $display("Failed read rs1")

        #10 rs2 <= 3'b000;
       if (data_rs2 != 'hAAAA) 
            $display("Failed read rs2")

    end
endmodule
