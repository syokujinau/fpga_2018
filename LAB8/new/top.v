`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:17:31 05/27/2016 
// Design Name: 
// Module Name:    top 
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
module top(i_CLK_50M,nRST,TXD);

input i_CLK_50M,nRST;
output TXD;
wire Baud_CLK;

div_clk u1(.i_CLK_50M(i_CLK_50M),.nRST(nRST),.o_CLK(Baud_CLK));
UART u2(.nRST(nRST),.TXD(TXD),.Baud_CLK(Baud_CLK));

endmodule
