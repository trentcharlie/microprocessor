`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    19:32:41 06/05/2020
// Design Name:
// Module Name:    Microprocessor
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Microprocessor(
    output clock,
    output mem_write,
    output mem_read,
    output reg_write,
    output [1:0]op,
    output [6:0]reg_num,
    output [6:0]pc_high,
    output [6:0]pc_low,
    output [7:0]instruction_address,
    output [6:0]rwd_1,
    output [6:0]rwd_0,
    output [1:0]r_symbol,
    input frequency_2,
    input frequency_4,
    input oscillator,
    input reset,
    input [7:0]instruction
    );

    //Frequency divider section
    reg [25:0] delay;
    reg delay_2;
    reg delay_4;
    reg sec;
    reg two_sec;
    reg four_sec;

    always @(posedge oscillator)begin
    	delay  <= (delay == 25000000)?26'd0:(delay+1);
    	if (delay == 26'd0)begin
    		sec <= ~sec;
    	end
    end

    always @ ( posedge sec ) begin
      two_sec <= ~two_sec;
    end

    always @ ( posedge two_sec ) begin
      four_sec <= ~four_sec;
    end

    assign clock = frequency_4 ? four_sec:
                    frequency_2 ? two_sec :
                    sec;

    //Memory and Registers section
    reg [7:0]registers[3:0];
    reg [7:0]pc;
    reg [7:0]memory[31:0];


    //Output convenience registers
    reg [4:0]rw_num;
    reg [1:0]op_out;
    reg data_invalid;
    reg reg_invalid;

    //buses
    wire [7:0]immediate;
    wire [7:0]display_bus = registers[rw_num];

	 //7-segment display
    Console data1(rwd_1, display_bus[7:4],data_invalid);
    Console data0(rwd_0, display_bus[3:0],data_invalid);
    Console  pc_counter_high(pc_high, pc[7:4],1'b0);
    Console  pc_counter_low(pc_low, pc[3:0], 1'b0);
    Console reg_num_(reg_num, rw_num,reg_invalid);

    //connections
    assign instruction_address = pc;
    assign immediate = {instruction[1],instruction[1],instruction[1],
                        instruction[1],instruction[1],instruction[1],
                        instruction[1],instruction[0]}; //signext
    assign mem_write = (op == 2'b10);
    assign mem_read = (op == 2'b01);
    assign reg_write = ~op[1];
    assign op = op_out;
    assign r_symbol = 2'b11;

    always @ (posedge clock or posedge reset) begin

		if (reset) begin
			//Asynchronous reset trigers a reset sequence

			//reset pc
			pc <= 8'd0;
			data_invalid <= 1'b1;
			reg_invalid <= 1'b1;

			//reset registers
			registers[0] <= 8'd0;
			registers[1] <= 8'd0;
			registers[2] <= 8'd0;
			registers[3] <= 8'd0;


			//reinitialize memory
			memory[0] <= 0;
			memory[1] <= 1;
			memory[2] <= 2;
			memory[3] <= 3;
			memory[4] <= 4;
			memory[5] <= 5;
			memory[6] <= 6;
			memory[7] <= 7;
			memory[8] <= 8;
			memory[9] <= 9;
			memory[10] <= 10;
			memory[11] <= 11;
			memory[12] <= 12;
			memory[13] <= 13;
			memory[14] <= 14;
			memory[15] <= 15;
			memory[16] <= 0;
			memory[17] <= -1;
			memory[18] <= -2;
			memory[19] <= -3;
			memory[20] <= -4;
			memory[21] <= -5;
			memory[22] <= -6;
			memory[23] <= -7;
			memory[24] <= -8;
			memory[25] <= -9;
			memory[26] <= -10;
			memory[27] <= -11;
			memory[28] <= -12;
			memory[29] <= -13;
			memory[30] <= -14;
			memory[31] <= -15;
		end


  else begin

			op_out <= instruction[7:6];

			//Default for RegWriteData display
		  data_invalid <= 1'b0;
		  reg_invalid <= 1'b0;


		  //Add instruction
        if (instruction[7:6] == 2'b00) begin
					pc <= pc+1;
			     rw_num <= instruction[1:0];
				registers[instruction[1:0]] <= registers[instruction[3:2]] +
                                registers[instruction[5:4]];
        end

        //Load instruction
        else if (instruction[7:6] == 2'b01) begin
					pc <= pc+1;
			     rw_num <= instruction[3:2];
					registers[instruction[3:2]] <= memory[registers[instruction[5:4]]+immediate];
        end

        //Store instruction
        else if (instruction[7:6] == 2'b10) begin
				pc <= pc+1;
				//RegWriteData irrelevant
			     data_invalid <= 1'b1;
			     reg_invalid <= 1'b1;

				//instruction body
			     memory[registers[instruction[5:4]]+immediate] <= registers[instruction[3:2]];
        end

        //Jump instruction
        else if (instruction[7:6] == 2'b11) begin

				//RegWriteData irrelevant
			     data_invalid <= 1'b1;
			     reg_invalid <= 1'b1;

				//instruction body
			     pc <= pc + immediate+1;
		    end
      end


	  end


endmodule
