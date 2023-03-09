`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    19:08:42 06/05/2020
// Design Name:
// Module Name:    Console
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
module Console(
    output [6:0]sseg,
    input [3:0]hex,
	 input n_valid  //Generate "-" invalid input indicator
    );
    assign sseg = (n_valid) ? 7'b1000000:
						(hex == 4'd0) ? 7'b0111111 :
						(hex == 4'd1) ? 7'b0000110 :
						(hex == 4'd2) ? 7'b1011011 :
						(hex == 4'd3) ? 7'b1001111:
						(hex == 4'd4) ? 7'b1100110 :
						(hex == 4'd5) ? 7'b1101101 :
						(hex == 4'd6) ? 7'b1111101 :
						(hex == 4'd7) ? 7'b0000111 :
						(hex == 4'd8) ? 7'b1111111 :
						(hex == 4'd9) ? 7'b1100111 :
						(hex == 4'd10) ? 7'b1110111 :
						(hex == 4'd11) ? 7'b1111100 :
						(hex == 4'd12) ? 7'b0111001 :
						(hex == 4'd13) ? 7'b1011110 :
						(hex == 4'd14) ? 7'b1111001 :
						7'b1110001 ;
endmodule
