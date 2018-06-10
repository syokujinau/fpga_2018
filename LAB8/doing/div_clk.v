`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:18:31 05/27/2016 
// Design Name: 
// Module Name:    div_clk 
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
module div_clk(i_CLK_50M,nRST,o_CLK);

input i_CLK_50M,nRST;

//Frequency divider
reg[25:0]clk_cnt;
output reg o_CLK;

parameter div_number=1302;
parameter div_unmber_half=div_number/2;
//Frequency divider
always@(posedge i_CLK_50M or negedge nRST)begin
    clk_cnt<=(!nRST)?0:(clk_cnt==(div_number-1))?0:clk_cnt+1'b1;
end

always@(posedge i_CLK_50M)begin
    o_CLK<=(clk_cnt<div_unmber_half)?0:1;
end

endmodule