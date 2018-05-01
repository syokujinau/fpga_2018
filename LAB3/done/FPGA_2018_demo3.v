module FPGA_2014_demo3(

output [11:0]out_led,
output [2:0]KPD_R,
input [3:0]KPD_C,
input clk,

output a,
output b,
output c,
output d,
output e,
output f,
output g,
output dp,
output [5:0]seg7_decode

);

reg [11:0]out_led;
reg [22:0]counter;

reg [7:0] seg7_display; 
wire d_clk;
assign d_clk = counter[22];

reg [5:0] seg7_run = 6'b100000;
assign seg7_decode = ~seg7_run;
//assign seg7_decode=~6'b000001;//

always @(posedge d_clk) begin

	seg7_run = {seg7_run[0], seg7_run[5:1]};

end

//
assign a=~seg7_display[7];
assign b=~seg7_display[6];
assign c=~seg7_display[5];
assign d=~seg7_display[4];
assign e=~seg7_display[3];
assign f=~seg7_display[2];
assign g=~seg7_display[1];
assign dp=~seg7_display[0];


always @(posedge clk)
begin
	counter <= counter+1'b1;
end

assign KPD_R = counter[14:12]; //scan 

always @(*)
begin
	case({KPD_R,KPD_C})
	7'b011_0111:begin 
					out_led = 12'b000000000001; 
					seg7_display = 8'b11111100;
				end //0
	7'b110_1110:begin 
					out_led = 12'b000000000010; 
					seg7_display = 8'b01100000;
				end //1
	7'b110_1101:begin 
					out_led = 12'b000000000100; 
					seg7_display = 8'b11011010;
				end //2
	7'b110_1011:begin 
					out_led = 12'b000000001000; 
					seg7_display = 8'b11110010;
				end //3
	7'b101_1110:begin 
					out_led = 12'b000000010000; 
					seg7_display = 8'b01100110;
				end //4
	7'b101_1101:begin 
					out_led = 12'b000000100000; 
					seg7_display = 8'b10110110; 
				end //5
	7'b101_1011:begin 
					out_led = 12'b000001000000; 
					seg7_display = 8'b10111110;
				end //6
	7'b011_1110:begin 
					out_led = 12'b000010000000; 
					seg7_display = 8'b11100100;
				end //7
	7'b011_1101:begin 
					out_led = 12'b000100000000; 
					seg7_display = 8'b11111110;
				end //8
	7'b011_1011:begin 
					out_led = 12'b001000000000; 
					seg7_display = 8'b11110110;
				end //9
	7'b110_0111:begin 
					out_led = 12'b010000000000; 
					seg7_display = 8'b10011110;
				end //10
	7'b101_0111:begin 
					out_led = 12'b100000000000; 
					seg7_display = 8'b10001110;
				end //11
	default:	begin 
					out_led = 12'b000000000000; 
					seg7_display = 8'b00000000;
					seg7_run = 6'b10_0000;
				end
	endcase
end


endmodule
