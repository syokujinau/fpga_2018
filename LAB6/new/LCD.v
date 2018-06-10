`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:06:12 11/06/2015 
// Design Name: 
// Module Name:    LCD 
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
module LCD(input clk, input nrst, output LCD_RW, output LCD_EN,output LCD_RS, output [7:0]LCD_DATA
    );

//DIVIDE
reg [25:0]clk_cnt;
reg o_CLK;

parameter div_number =5000; //100000ns
parameter div_unmber_half=div_number/2;

always @(posedge clk or negedge nrst)begin
clk_cnt <= (!nrst)?0:(clk_cnt==(div_number-1))?0:clk_cnt+1'b1;
end
always @(posedge clk)begin
o_CLK <=(clk_cnt < div_unmber_half)?0:1;
end


//LCDM_CNT
reg [5:0]cnt;
reg LCD_RWr,LCD_RSr;
reg [7:0]LCD_DATAr;

assign LCD_RW=LCD_RWr;
assign LCD_RS=LCD_RSr;
assign LCD_DATA=LCD_DATAr;

//en
wire LCDM_CLK;
assign LCDM_CLK=o_CLK;
assign LCD_EN = LCDM_CLK;

//LCDM_CNT     
always@(posedge LCDM_CLK or negedge nrst)begin
	if(!nrst)begin
		cnt <= 6'd0; end
	else if(cnt < 6'd37)begin
		cnt <= cnt + 1'd1;end
	else begin
		cnt <= 6'd4; end
	
   if(!nrst)begin
		LCD_RWr <= 1'b0;
		LCD_RSr <= 1'b0;
		LCD_DATAr <= 8'd0; end
	else begin
	
	case(cnt)
		6'd0: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h38;end
		6'd1: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h01;end
		6'd2: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h06;end
		6'd3: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h0C;end
		6'd4:begin
			 LCD_RSr <= 1'b0;
			 LCD_DATAr <= 8'h80;
			end
		6'd5:begin
			 LCD_RSr <= 1'b1;
			 LCD_DATAr <= " ";
			end
		6'd6: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd7: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd8: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd9: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd10: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd11: begin LCD_RSr <= 1'b1; LCD_DATAr <= "C";end
		6'd12: begin LCD_RSr <= 1'b1; LCD_DATAr <= "I";end
		6'd13: begin LCD_RSr <= 1'b1; LCD_DATAr <= "C";end
		6'd14: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd15: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd16: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd17: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd18: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd19: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd20: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd21:begin
			 LCD_RSr <= 1'b0;
			 LCD_DATAr <= 8'hC0;
			end
		6'd22:begin
			 LCD_RSr <= 1'b1;
			 LCD_DATAr <= "M";
			end
		6'd23: begin LCD_RSr <= 1'b1; LCD_DATAr <= "o";end
		6'd24: begin LCD_RSr <= 1'b1; LCD_DATAr <= "r";end
		6'd25: begin LCD_RSr <= 1'b1; LCD_DATAr <= "F";end
		6'd26: begin LCD_RSr <= 1'b1; LCD_DATAr <= "P";end
		6'd27: begin LCD_RSr <= 1'b1; LCD_DATAr <= "G";end
		6'd28: begin LCD_RSr <= 1'b1; LCD_DATAr <= "A";end
		6'd29: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
		6'd30: begin LCD_RSr <= 1'b1; LCD_DATAr <= "P";end
		6'd31: begin LCD_RSr <= 1'b1; LCD_DATAr <= "l";end
		6'd32: begin LCD_RSr <= 1'b1; LCD_DATAr <= "a";end
		6'd33: begin LCD_RSr <= 1'b1; LCD_DATAr <= "t";end
		6'd34: begin LCD_RSr <= 1'b1; LCD_DATAr <= "f";end
		6'd35: begin LCD_RSr <= 1'b1; LCD_DATAr <= "o";end
		6'd36: begin LCD_RSr <= 1'b1; LCD_DATAr <= "r";end
		6'd37: begin LCD_RSr <= 1'b1; LCD_DATAr <= "m";end
		default: begin
				LCD_RSr <= LCD_RSr; LCD_DATAr <= LCD_DATAr; end
		endcase
		end
	end
	
endmodule
