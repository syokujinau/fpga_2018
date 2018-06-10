module LAB4(a,b,c,d,e,f,g,dp,seg7_decode,clk,ROT,rst);

output a,b,c,d,e,f,g,dp;
output [5:0] seg7_decode;
input clk;
input rst;
input [3:0] ROT;

reg [7:0] seg7_display;
reg [5:0] seg7;
reg [28:0] COUNT,COUNT1;
reg [3:0] flag; 
reg [3:0] flag0 = 4'd0, 
          flag1 = 4'd0, 
		  flag2 = 4'b1111, 
		  flag3 = 4'd0,
		  flag4 = 4'd6;

parameter 	num0 = 8'b11111100,
			num1 = 8'b01100000,
			num2 = 8'b11011010,
			num3 = 8'b11110010,
			num4 = 8'b01100110,
			num5 = 8'b10110110,
			num6 = 8'b10111110,
			num7 = 8'b11100100,
			num8 = 8'b11111110,
			num9 = 8'b11100110,
			numE = 8'b10011110,
			dash = 8'b00000010;

always @(posedge clk) 
   begin
		if (ROT!=4'b1111)
			begin
				COUNT <= COUNT + 1; 
			end
		else
			begin
				COUNT <= COUNT ; 
			end	
		COUNT1	<= COUNT1 +1 ;	
   end
	
always @(posedge COUNT[22])
	begin
		
		if(flag0 == 4'd0) begin 
			flag0 <= 4'd9; //overflow	

			if(flag1 == 4'd0) begin
				flag1 <= 4'd5; //overflow

				if(flag3 == 4'd0) begin
					flag3 <= 4'd9; //overflow

					if(flag4 == 4'd0) begin
						flag4 <= 4'd6; //overflow
					end
					else flag4 <= flag4 - 1;

				end
				else flag3 <= flag3 - 1;

			end
			else flag1 <= flag1 - 1;

		end
		else flag0 <= flag0 - 1;

		flag2 <= flag2;
		
	end
	
always@(posedge COUNT1[10])
	if(~rst)
		seg7 <= 6'b000000;
	else if (seg7 == 6'b010_0_00) //sec left
		begin
		flag <= flag0;
		seg7 <= 6'b000_0_01;
		end
	else if (seg7 == 6'b000_0_01) //sec right
		begin
		flag <= flag1;
		seg7 <= 6'b000_0_10;
		end

	else if (seg7 == 6'b000_0_10) // dash
		begin
		flag <= flag2;
		seg7 <= 6'b000_1_00;
		end

	else if (seg7 == 6'b000_1_00) //min left
		begin
		flag <= flag3;
		seg7 <= 6'b001_0_00;
		end
	else                        //min right
		begin
		flag <= flag4;
		seg7 <= 6'b010_0_00;
		end

		
always@(posedge clk)
	begin
		case(flag)
			4'd0 :
				begin
					seg7_display <= num0;
				end
			4'd1 :
				begin
					seg7_display <= num1;
				end
			4'd2 :
				begin
					seg7_display <= num2;
				end
			4'd3 :
				begin
					seg7_display <= num3;
				end
			4'd4 :
				begin
					seg7_display <= num4;
				end
			4'd5 :
				begin
					seg7_display <= num5;
				end
			4'd6 :
				begin
					seg7_display <= num6;
				end
			4'd7 :
				begin
					seg7_display <= num7;
				end
			4'd8 :
				begin
					seg7_display <= num8;
				end
			4'd9 :
				begin
					seg7_display <= num9;
				end
			4'b1111 :
				begin
					seg7_display <= dash;
				end

			default: 
				begin
					seg7_display <= numE;
				end
		endcase
		
	end
 
assign seg7_decode = ~seg7;
assign a  = ~seg7_display[7];
assign b  = ~seg7_display[6];
assign c  = ~seg7_display[5];
assign d  = ~seg7_display[4];
assign e  = ~seg7_display[3];
assign f  = ~seg7_display[2];
assign g  = ~seg7_display[1];
assign dp = ~seg7_display[0];

endmodule

