module LAB4(a,b,c,d,e,f,g,dp,seg7_decode,clk,ROT,rst);

output a,b,c,d,e,f,g,dp;
output [5:0] seg7_decode;
input clk;
input rst;
input [3:0] ROT;

reg [7:0] seg7_display;
reg [5:0] seg7;
reg [28:0] COUNT,COUNT1;
reg [2:0] flag,flag0,flag1;
parameter 		num0=8'b11111100,
				num1=8'b01100000,
				num2=8'b11011010,
				num3=8'b11110010,
				num4=8'b01100110,
				num5=8'b10110110,
				num6=8'b10111110,
				num7=8'b11100100,
				numE=8'b10011110;

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
	
always @(COUNT)
	begin
		flag1[2:0]=COUNT[28:26];
		flag0[2:0]=COUNT[25:23];
	end
	
always@(posedge COUNT1[10])
	if(~rst)
		seg7<=6'b000000;
	else if (seg7==6'b000001)
		begin
		flag<=flag1;
		seg7<=6'b000010;
		end
	else 
		begin
		flag<=flag0;
		seg7<=6'b000001;
		end
		
always@(posedge clk)
	begin
		case(flag)
		3'b000 :
			begin
				seg7_display<=num0;
			end
		3'b001 :
			begin
				seg7_display<=num1;
			end
		3'b010 :
			begin
				seg7_display<=num2;
			end
		3'b011 :
			begin
				seg7_display<=num3;
			end
		3'b100 :
			begin
				seg7_display<=num4;
			end
		3'b101 :
			begin
				seg7_display<=num5;
			end
		3'b110 :
			begin
				seg7_display<=num6;
			end
		3'b111 :
			begin
				seg7_display<=num7;
			end
		default: 
			begin
				seg7_display<=numE;
			end
		endcase
		
	end
 
assign seg7_decode=~seg7;
assign a=~seg7_display[7];
assign b=~seg7_display[6];
assign c=~seg7_display[5];
assign d=~seg7_display[4];
assign e=~seg7_display[3];
assign f=~seg7_display[2];
assign g=~seg7_display[1];
assign dp=~seg7_display[0];

endmodule

