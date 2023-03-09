`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:45:10 06/15/2020
// Design Name:   Microprocessor
// Module Name:   /csehome/sjarelkral/Work/Microprocessor/Microprocessor/test.v
// Project Name:  Microprocessor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Microprocessor
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg frequency_2;
	reg frequency_4;
	reg oscillator;
	reg reset;
	reg [7:0] instruction;

	// Outputs
	wire clock;
	wire mem_write;
	wire mem_read;
	wire reg_write;
	wire [1:0] op;
	wire [6:0] reg_num;
	wire [6:0] pc_high;
	wire [6:0] pc_low;
	wire [7:0] instruction_address;
	wire [6:0] rwd_1;
	wire [6:0] rwd_0;
	wire [1:0] r_symbol;

	// Instantiate the Unit Under Test (UUT)
	Microprocessor uut (
		.clock(clock), 
		.mem_write(mem_write), 
		.mem_read(mem_read), 
		.reg_write(reg_write), 
		.op(op), 
		.reg_num(reg_num), 
		.pc_high(pc_high), 
		.pc_low(pc_low), 
		.instruction_address(instruction_address), 
		.rwd_1(rwd_1), 
		.rwd_0(rwd_0), 
		.r_symbol(r_symbol), 
		.frequency_2(frequency_2), 
		.frequency_4(frequency_4), 
		.oscillator(oscillator), 
		.reset(reset), 
		.instruction(instruction)
	);
	initial begin
	oscillator = 0;
	end
	always #10 oscillator = ~oscillator;
	
	initial begin
		// Initialize Inputs
		frequency_2 = 0;
		frequency_4 = 0;
		reset = 1;

		// Wait 100 ns for global reset to finish
		#15;
		
		
        reset = 0;
		// Add stimulus here
		
		// lw $s2, 1($s0)
	 instruction  = {2'b01, 2'b00, 2'b10, 2'b01};
	 		#20;


   // j + 1
   instruction = {2'b11, 2'b00, 2'b00, 2'b01};
	
			#20;


   // add $s0, $s1 $s2
   instruction = {2'b00, 2'b01, 2'b10, 2'b00};
	
			#20;


   // sw $s2, 1($s2)
   instruction  = {2'b10, 2'b10, 2'b10, 2'b01};
	
			#20;


   // lw $s3, 1($s0)
   instruction = {2'b01, 2'b01, 2'b11, 2'b01};
			#20;

		
		

	end
      
endmodule

