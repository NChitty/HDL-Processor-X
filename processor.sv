module processor(
  input clk,
  input rst,
);

reg [12:0] pc; // pc is from mem address 0x0000 to 0x1FFF
reg [15:0] instruction;
reg [4:0] opcode;
reg [15:0] alu_result;

// register interface
reg [15:0] rs1, rs2, rd;
wire register_write_enable;
register_bus regbus (
    .rs1(instruction[5:3]),
    .rs2(instruction[2:0]),
    .rd(instruction[11:9]),
    .data_in(rd),
    .we(register_write_enable),
    .data_rs1(rs1),
    .data_rs2(rs2)
);

// memory interface
wire [13:0] mem_addr; // data memory is from 0x2000 to 0x3FFF
wire [15:0] mem_data_in;
wire mem_write_enable;
reg [15:0] mem_data_out;

registers reg_file (regbus);
alu alu(.op(instruction[5:0]), .a(reg_file.read_data_1), .b(reg_file.read_data_2), .result(alu_result));
memory mem (.addr(mem_addr), .data_in(mem_data_in), .we(mem_write_enable), .data_out(mem_data_out));

always @(posedge clk) begin
  if (rst) begin
    pc <= 0;
    rs1 <= 0;
    rs2 <= 0;
    rd <= 0;
    // write program memory
  end else begin
    // Fetch instruction
    pc <= pc + 2;
    mem_addr <= pc;
    instruction <= mem_data_out;

    // Decode instruction
    opcode = instruction[15:12]; // the registers are filled automagically by the interface

    if (opcode != 'b0) begin // skip everything if NOP
        // Execute instruction
        if (opcode == 'h8) begin // MV rd 9-bit immediate
            rd <= instruction[8:0];
            register_write_enable <= 'b1;
        end else if (opcode < 8) begin // ALU  opcode
            reg_file.read_addr_1 <= rs;
            reg_file.read_addr_2 <= rt;
            reg_file.write_addr <= rd;
            alu.a <= reg_file.read_data_1;
            alu.b <= reg_file.read_data_2;
            mem.address <= alu_result;
        end
    end
  end
end

endmodule
