module TestLED(clk,rst,out,inpulse);
output [11:0] out;
input [3:0] inpulse;
input clk,rst;

reg [3:0] COUNT;
reg [11:0] out_r;
reg [20:0] counter;
wire d_clk;

always @ (inpulse)
	COUNT=~inpulse;
	
always @ (posedge clk)
	counter <=counter+1'b1;
	
assign d_clk=counter[20];

always @ (posedge d_clk)
begin
	if (rst)
		out_r<=12'd1;
	else if (COUNT==4'b0001)
		out_r<={out_r[0],out_r[11:1]};
	else
		out_r<=out_r;
end
		
assign out[11:0]=out_r[11:0];

endmodule
