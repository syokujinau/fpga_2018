	`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:29:07 05/12/2016 
// Design Name: 
// Module Name:    VGA_640_480 
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
module d_clk( //25MHZ
	input 	  i_clk,
	input 	  rst_N, 
	output reg o_clk);

reg  clk_cnt;
parameter divisor = 2;
parameter half_div = divisor / 2;

always @(posedge i_clk or negedge rst_N)
begin 
		clk_cnt <= (!rst_N)? 0 : (clk_cnt == (divisor-1))? 1'b0 : clk_cnt + 1'b1;
		o_clk <= (!rst_N)? 0 : (clk_cnt < half_div)? 1'b0 : 1'b1; 
end
endmodule
/////////////////////////////////////////// Sub Moudle END/////////////////////////////////////////

module VGA_640_480( 
	input 					RST_N,
   input          		CLOCK_50,      // 50 MHz
	output         		VGA_HS,        // Horizontal synchronize signal
   output         		VGA_VS,        // Vertical synchronize signal
   output	reg	[2:0]	VGA_RGB       // Signal RED, Green, Blue   
);
// Horizontal Parameter
parameter H_FRONT = 16;
parameter H_SYNC  = 96;
parameter H_BACK  = 48;
parameter H_ACT   = 640;
parameter H_TOTAL = H_FRONT + H_SYNC + H_BACK + H_ACT;

// Vertical Parameter
parameter V_FRONT = 10;
parameter V_SYNC  = 2;
parameter V_BACK  = 33;
parameter V_ACT   = 480;
parameter V_TOTAL = V_FRONT + V_SYNC + V_BACK + V_ACT;

wire 		 CLK_25;		// 25MHz clk
reg [9:0] H_cnt; 
reg [9:0] V_cnt;
reg       vga_hs;		// register for horizontal synchronize signal
reg       vga_vs;		// register for vertical synchronize signal
reg [9:0] X;			// from 1~640
reg [8:0] Y;			// from 1~480

assign VGA_HS = vga_hs;
assign VGA_VS = vga_vs;

// sub moudle
d_clk u1(.i_clk(CLOCK_50), .o_clk(CLK_25), .rst_N(RST_N));

// Horizontal counter
always@(posedge CLK_25, negedge RST_N) // count 0~800
begin
	H_cnt <= (!RST_N)? H_TOTAL : (H_cnt < H_TOTAL)?  H_cnt+1'b1 : 10'd0; 
end
// vertical counter
always@(posedge VGA_HS, negedge RST_N) // count 0~525
begin
	V_cnt <= (!RST_N)? V_TOTAL : (V_cnt < V_TOTAL)?  V_cnt+1'b1 : 10'd0; 
end
// Horizontal Generator: Refer to the pixel clock
always@(posedge CLK_25, negedge RST_N) 
begin
	if(!RST_N) begin	
		vga_hs <= 1;
		X      <= 0;
	end
	else begin
		// Horizontal Sync
		if( H_FRONT<=H_cnt&&H_cnt<( H_FRONT+H_SYNC)) //Front porch  end	 Sync pulse start
			vga_hs <= 1'b0;// horizontal synchronize pulse
      else
			vga_hs <= 1'b1;
		// Current X
		if((H_FRONT+H_SYNC+H_BACK)<=H_cnt&&H_cnt<H_TOTAL )// 
			X <= (H_cnt==(H_FRONT+H_SYNC+H_BACK))?1'b1:(X+1'b1);
		else
			X <= 0;
	end
end			
// Vertical Generator: Refer to the horizontal sync
always@(posedge VGA_HS, negedge RST_N) begin
	if(!RST_N) begin
		vga_vs <= 1;
		Y      <= 0;
	end
	else begin      
		// Vertical Sync
		if ( V_FRONT<=V_cnt&&V_cnt<( V_FRONT+V_SYNC)) // Front porch  end	 Sync pulse start
			vga_vs <= 1'b0;
		else
			vga_vs <= 1'b1;
		// Current Y
		if((V_FRONT+V_SYNC+V_BACK)<=V_cnt&&V_cnt<V_TOTAL )
			Y <= (V_cnt==(V_FRONT+V_SYNC+V_BACK))?1'b1:(Y+1'b1);
		else
			Y <= 0;
	end
end


// Demo pattern
always@(*) 
begin
	if( (X >= 1) && (X <= 80) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b000;	
	else if( (X >= 81) && (X <= 160) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b001;
	else if( (X >= 161) && (X <= 240) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b010;
	else if( (X >= 241) && (X <= 320) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b011;
	else if( (X >= 321) && (X <= 400) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b100;
	else if( (X >= 401) && (X <= 480) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b101;
	else if( (X >= 481) && (X <= 560) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b110;
	else if( (X >= 561) && (X <= 640) && (Y > 0) && (Y <= 480) )
		VGA_RGB = 3'b111;	
	else
		VGA_RGB = 3'b000;
end

endmodule
