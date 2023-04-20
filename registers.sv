`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2023 03:18:47 PM
// Design Name: 
// Module Name: registers
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module registers(
  register_bus intf
);

  reg [15:0] regs [0:7];

  always @(intf.rd, intf.data_in, intf.we) begin
    if (intf.we) begin
      regs[intf.rd] <= intf.data_in;
    end
  end

  always @(intf.rs1, intf.rs2) begin
    intf.data_rs1 <= regs[intf.rs1];
    intf.data_rs2 <= regs[intf.rs2];
  end

endmodule

