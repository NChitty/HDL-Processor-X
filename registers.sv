`timescale 1ns / 1ps
module registers(
  register_bus intf
);

  reg [15:0] regs [0:7];

  // for simulations
  integer i;
  initial begin
      for (i = 0; i <=7; i=i+1)
          regs[i] = 16'b0;
  end

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
