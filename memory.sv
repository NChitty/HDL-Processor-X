`timescale 1ns / 1ps

module memory(
    input [13:0] addr,
    input [15:0] data_in,
    input we,
    output [15:0] data_out 
);

reg [7:0] mem[0:16393];

// for simulations
integer i;
initial begin
    for (i = 0; i <=16393; i=i+1)
        mem[i] = 8'b0;
end

always @(addr, we, data_in) begin
    if(we) begin
        mem[addr] <= data_in[15:8];
        mem[addr - 1] <= data_in[7:0];
    end
    else begin
        data_out <= (mem[addr] << 8) + mem[addr-1];
    end
end

endmodule