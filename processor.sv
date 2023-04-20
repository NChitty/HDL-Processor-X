module processor(
  input clk,
  input rst,
);

wire [13:0] mem_addr; // data memory is from 0x2000 to 0x3FFF
wire [15:0] mem_data_in;
wire mem_write_enable;
reg [15:0] mem_data_out;

reg [12:0] pc; // pc is from mem address 0x0000 to 0x1FFF
reg [15:0] instruction;
reg [4:0] opcode;
reg [15:0] rs1, rs2, rd;
reg [15:0] alu_result;

registers reg_file(.rs(rs), .rt(rt), .rd(rd), .wr(rd), .clk(clk), .rst(rst));
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
    rs1 <= instruction[25:21];
    rs2 <= instruction[20:16];
    rd <= instruction[15:11];

    // Execute instruction
    reg_file.read_addr_1 <= rs;
    reg_file.read_addr_2 <= rt;
    reg_file.write_addr <= rd;
    alu.a <= reg_file.read_data_1;
    alu.b <= reg_file.read_data_2;
    mem.address <= alu_result;
    // Memory access
    if (instruction[31:26] == 32'b100000) begin
      mem.write_enable <= 1;
      mem.data_in <= reg_file.read_data_2;
    end else begin
      mem.write_enable <= 0;
    end
    // Writeback
    if (instruction[31:26] == 32'b101011) begin
      reg_file.write_enable <= 1;
      reg_file.write_data <= mem_data;
    end else if (instruction[31:26] == 32'b101010) begin
      reg_file.write_enable <= 1;
      reg_file.write_data <= alu_result;
    end else begin
      reg_file.write_enable <= 0;
    end
  end
end

endmodule
