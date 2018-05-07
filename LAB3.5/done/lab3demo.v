module lab3demo(out_led,KPD_R,seg7_decode,a,b,c,d,e,f,g,dp,KPD_C,clk,rst);

output [11:0]out_led;
output reg [2:0]KPD_R;
output [5:0]seg7_decode;
output a,b,c,d,e,f,g,dp;
input [3:0]KPD_C;
input clk,rst;

reg [11:0]out_r;
reg [24:0]counter;
reg [7:0]seg7_display;
reg [7:0]seg7_temp;
wire dclk;

//********************
reg [5:0] seg7_run = 6'b10_0000;
assign seg7_decode = ~seg7_run;

always @(posedge dclk) begin
	if(KPD_C == 4'b1111)
		seg7_run = 6'b10_0000;
	else 
	   seg7_run = {seg7_run[0], seg7_run[5:1]};
end
//********************

//assign seg7_decode = ~6'b000001;

always @(posedge clk)
begin
	counter <= counter+1'b1;
end

assign out_led = out_r;
assign dclk = counter[20];

always@(posedge dclk or negedge rst )
begin
	if(~rst)
		KPD_R<= 3'b110;
	else if(KPD_C==4'b1111)
		KPD_R <= {KPD_R[1:0],KPD_R[2]};
	else
		KPD_R <= KPD_R;
end

always@(posedge clk or negedge rst)
begin
	if(~rst)
	begin
		seg7_temp <= 8'b0;
	end
	else
	begin
		seg7_temp <= seg7_display;
	end
	
end
always @(*)
begin
	case({KPD_R,KPD_C})
	7'b011_0111:begin out_r = 12'b000000000001; seg7_display = 8'b11111100;  end //0
	7'b110_1110:begin out_r = 12'b000000000010; seg7_display = 8'b01100000;  end //1
	7'b110_1101:begin out_r = 12'b000000000100; seg7_display = 8'b11011010;  end //2
	7'b110_1011:begin out_r = 12'b000000001000; seg7_display = 8'b11110010;  end //3
	7'b101_1110:begin out_r = 12'b000000010000; seg7_display = 8'b01100110;  end //4
	7'b101_1101:begin out_r = 12'b000000100000; seg7_display = 8'b10110110;  end //5
	7'b101_1011:begin out_r = 12'b000001000000; seg7_display = 8'b10111110;  end //6
	7'b011_1110:begin out_r = 12'b000010000000; seg7_display = 8'b11100100;  end //7
	7'b011_1101:begin out_r = 12'b000100000000; seg7_display = 8'b11111110;  end //8
	7'b011_1011:begin out_r = 12'b001000000000; seg7_display = 8'b11100110;  end //9
	7'b110_0111:begin out_r = 12'b010000000000; seg7_display = 8'b10011110;  end //10
	7'b101_0111:begin out_r = 12'b100000000000; seg7_display = 8'b10001110;  end //11
	default:
	begin 
	out_r = 12'b000000000000; 
	seg7_display = seg7_temp;
	end
	endcase
end

assign a=~seg7_display[7];
assign b=~seg7_display[6];
assign c=~seg7_display[5];
assign d=~seg7_display[4];
assign e=~seg7_display[3];
assign f=~seg7_display[2];
assign g=~seg7_display[1];
assign dp=~seg7_display[0];

endmodule