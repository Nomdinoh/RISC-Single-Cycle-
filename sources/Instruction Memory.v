`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2024 06:51:42 PM
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(
input reset,
input [31:0] A,
output [31:0] RD
    );
    
    reg [31:0] Mem [1023:0];
    
    assign RD = (reset)? 32'b0 : Mem[A[31:2]];
    
    initial begin
        Mem[0] = 32'h00500113;
        Mem[1] = 32'h00C00193;
        Mem[2] = 32'hFF718393;
        Mem[3] = 32'h0023E233;
        Mem[4] = 32'h0041F2B3;
        Mem[5] = 32'h004282B3;
    end
    
endmodule
