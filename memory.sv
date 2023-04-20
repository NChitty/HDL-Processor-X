`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/14/2023 03:09:45 PM
// Design Name: 
// Module Name: memory
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

module memory(
    input [13:0] addr,
    input [15:0] data_in,
    input we,
    output [15:0] data_out 
);

reg [7:0] mem[0:16393];

always @(addr or we) begin
    if(we) begin
        mem[addr] <= data_in[15:8];
        mem[addr - 1] <= data_in[7:0];
    end
    else begin
        data_out <= mem[addr] + mem[addr-1];
    end
end

endmodule