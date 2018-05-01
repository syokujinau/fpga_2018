module FPGA_2014_demo3(out_led,KPD_R,KPD_C,clk);

output [11:0]out_led;
output [2:0]KPD_R;
input [3:0]KPD_C;
input clk;

reg [11:0]out_led;
reg [28:0]counter;

always @(posedge clk)
begin
	counter <= counter+1'b1;
end

assign KPD_R = counter[28:26];

always @(*)
begin
	case({KPD_R,KPD_C})
	7'b011_0111:begin out_led = 12'b000000000001; end //0
	7'b110_1110:begin out_led = 12'b000000000010; end //1
	7'b110_1101:begin out_led = 12'b000000000100; end //2
	7'b110_1011:begin out_led = 12'b000000001000; end //3
	7'b101_1110:begin out_led = 12'b000000010000; end //4
	7'b101_1101:begin out_led = 12'b000000100000; end //5
	7'b101_1011:begin out_led = 12'b000001000000; end //6
	7'b011_1110:begin out_led = 12'b000010000000; end //7
	7'b011_1101:begin out_led = 12'b000100000000; end //8
	7'b011_1011:begin out_led = 12'b001000000000; end //9
	7'b110_0111:begin out_led = 12'b010000000000; end //10
	7'b101_0111:begin out_led = 12'b100000000000; end //11
	default:begin out_led = 12'b000000000000; end
	endcase
end


endmodule