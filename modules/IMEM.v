`timescale 1ns / 1ps
module IMEM(
    output [7:0] instruction,
    input [7:0] Read_Address
    );

wire [7:0] MemByte[8:0];

assign MemByte[0] = 8'b01000001; // s[0] = Mem[s[0] + 1]    //1
assign MemByte[1] = 8'b00000000; // s[0] = s[0] + s[0]      //2
assign MemByte[2] = 8'b00000000;                            //4
assign MemByte[3] = 8'b00000000;                            //8
assign MemByte[4] = 8'b00000000;                            //10
assign MemByte[5] = 8'b01101001; // s[2] = Mem[s[2] + 1]    //1
assign MemByte[6] = 8'b10110001; // Mem[s[3] + 1] = s[0]      //
assign MemByte[7] = 8'b01111001; // s[2] = Mem[s[3] + 1]    //10
assign MemByte[8] = 8'b11000010; // jump -2                  //10 10 10

assign instruction = MemByte[Read_Address];


endmodule
