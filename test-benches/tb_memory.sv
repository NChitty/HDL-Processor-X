`timescale 1ns / 1ps

module TB_MEM;
    reg [13:0] addr;
    reg [15:0] data_in;
    reg we;
    reg [15:0] data_out;

    memory mem (addr, data_in, we, data_out);

    initial begin
        addr <= 14'b0;
        data_in <= 16'b0;
        we <= 1'b0;

        #10 addr <= 14'h0002;
        if (data_out != 16'h0000) begin
            $display("Failed read");
        end

        #10 addr <= 14'h1FFF;
        data_in <= 16'hAAAA;
        we <= 1'b1;

        #5 we <= 1'b0;
        if (data_out != data_in) begin
            $display("Failed write");
        end
    end
endmodule