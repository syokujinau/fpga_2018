module LAB4(a,b,c,d,e,f,g,dp,seg7_decode,clk,ROT);

output a,b,c,d,e,f,g,dp;
output [5:0] seg7_decode;
input clk;
input [3:0] ROT;

reg [7:0] seg7_display;
reg [5:0] seg7;
reg speed;
reg [28:0] COUNT,COUNT1;
reg [2:0] flag,flag0,flag1;
wire [7:0] num0,num1,num2,num3,num4,num5,num6,num7,numE;

//建立7段顯示器數字表
assign num0=8'b11111100;
assign num1=8'b01100000;
assign num2=8'b11011010;
assign num3=8'b11110010;
assign num4=8'b01100110;
assign num5=8'b10110110;
assign num6=8'b10111110;
assign num7=8'b11100100;
assign numE=8'b10011110;

always @(posedge clk) begin
		if (ROT!=4'b1111) begin
			COUNT <= COUNT + 1; //COUNT給數字切換速度
		end
		COUNT1 <= COUNT1 + 1; //COUNT1給七段切換速度
end
	
always @(COUNT) begin
	flag1[2:0]=COUNT[28:26]; //十位數
	flag0[2:0]=COUNT[25:23]; //個位數
	speed=COUNT1[10];  //七段切換速度
end
	
always@(posedge speed)
	if (seg7==6'b000001) begin
		flag=flag1;  //要顯示的數字
		seg7=6'b000010; //七段切換
	end
	else  begin
		flag=flag0;
		seg7=6'b000001;
	end
		
always@(seg7) begin
	case(flag)
		3'b000 :
			begin
				seg7_display=num0;
			end
		3'b001 :
			begin
				seg7_display=num1;
			end
		3'b010 :
			begin
				seg7_display=num2;
			end
		3'b011 :
			begin
				seg7_display=num3;
			end
		3'b100 :
			begin
				seg7_display=num4;
			end
		3'b101 :
			begin
				seg7_display=num5;
			end
		3'b110 :
			begin
				seg7_display=num6;
			end
		3'b111 :
			begin
				seg7_display=num7;
			end
		default: 
			begin
				seg7_display=numE;
			end 
	endcase
end
 
assign seg7_decode = ~seg7;
assign a = ~seg7_display[7];
assign b = ~seg7_display[6];
assign c = ~seg7_display[5];
assign d = ~seg7_display[4];
assign e = ~seg7_display[3];
assign f = ~seg7_display[2];
assign g = ~seg7_display[1];
assign dp= ~seg7_display[0];
endmodule

