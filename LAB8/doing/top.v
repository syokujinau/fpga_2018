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
module top(i_CLK_50M,nRST,RXD, LCD_RW, LCD_EN, LCD_RS, LCD_DATA);

input i_CLK_50M,nRST,RXD;
output LCD_RW, LCD_EN, LCD_RS, LCD_DATA;
//output TXD;
//input RXD;
wire Baud_CLK;

wire [7:0] r_d;

div_clk u1(.i_CLK_50M(i_CLK_50M),.nRST(nRST),.o_CLK(Baud_CLK));
UART u2(.nRST(nRST),.RXD(RXD),.Baud_CLK(Baud_CLK),.OUTPUT(r_d));
LCD u3(.rx_data(r_d), 
	   .clk(i_CLK_50M), 
	   .nrst(nRST), 
	   .LCD_RW(LCD_RW), 
	   .LCD_EN(LCD_EN), 
	   .LCD_RS(LCD_RS), 
	   .LCD_DATA(LCD_DATA));

endmodule
