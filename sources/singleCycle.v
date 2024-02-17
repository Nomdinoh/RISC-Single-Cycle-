`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/16/2024 11:01:40 PM
// Design Name: 
// Module Name: singleCycle
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


module singleCycle(
input clk,reset
    );
    
    wire [31:0] PCTargetE,PCPlus4F,PCNextF,PCF,InstrD,ResultW,ImmExtD,ALUResultE,ReadData;
    wire PCSrcE,RegWriteE;
    
    wire [31:0] RD1_E,RD2_E,SrcB_E;
    wire zeroE,MemWriteE,ALUSrcE;
    wire [1:0] ResultSrcE,ImmSrcE;
    
    wire [2:0] ALUControlE;
    
    mux_fetch f1(
        .PCTarget(PCTargetE),.PCPlus4(PCPlus4F),.PCSrc(PCSrcE),
        .PCNext(PCNextF)
        );
    Program_Counter f2(
        .clk(clk),.reset(reset),
        .PCNext(PCNextF),
        .PC(PCF)
            );  
    PCPlus4 f3(
        .PC(PCF),
        .PCPlus4(PCPlus4F)
            );  
    Instruction_Memory f4(
         .reset(reset),
         .A(PCF),
         .RD(InstrD)
            );
    Reg_File d1(
         .clk(clk),.reset(reset),
         .WE3(RegWriteE),
         .A1(InstrD[19:15]),.A2(InstrD[24:20]),.A3(InstrD[11:7]),
         .WD3(ResultW),
         .RD1(RD1_E),.RD2(RD2_E)
           ); 
    Control_Unit d2(
         .zero(zeroE),
         .Instr(InstrD),
         .PCSrc(PCSrcE),
         .ResultSrc(ResultSrcE),
         .MemWrite(MemWriteE),
         .ALUSrc(ALUSrcE),
         .ImmSrc(ImmSrcE),
         .RegWrtie(RegWriteE),
//         .ALUOp(),
         .ALUControl(ALUControlE)
           );   
    Sign_Extension d3(
         .ImmSrc(ImmSrcE),
         .Instr(InstrD[31:7]),
         .ImmExt(ImmExtD)
          );  
    execute_mux e1(
          .RD2(RD2_E),
          .ImmExt(ImmExtD),
          .ALUSrc(ALUSrcE),
          .SrcB(SrcB_E)
              ); 
    PCTarget e2(
          .PC(PCF),
          .ImmExt(ImmExtD),
          .PCTarget(PCTargetE)  
              );
    ALU e3(
          .SrcAE(RD1_E), .SrcBE(SrcB_E),
          .ALUControlE(ALUControlE),
          .ALUResult(ALUResultE),
          .zero(zeroE)
           ); 
    Data_Memory M1(
          .clk(clk),.reset(reset),
          .WE(MemWriteE),
          .A(ALUResultE),.WD(RD2_E),
          .RD(ReadData)
           );  
    WriteBack_MUX w1(
          .ResultSrc(ResultSrcE),
          .ALUResult(ALUResultE),
          .ReadData(ReadData),.PCPlus4(PCPlus4F),
          .Result(ResultW)
               );                                                                                       
endmodule
