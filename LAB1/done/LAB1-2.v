module TestLED(clk,rst,out,inpulse);
output [11:0] out;
input [3:0] inpulse;
input clk,rst;

reg [3:0] COUNT;
reg [11:0] out_r;
reg [20:0] counter;
wire d_clk;

reg flag = 0;  //

always @ (inpulse)
	COUNT=~inpulse;
	
always @ (posedge clk)
	counter <=counter+1'b1;
	
assign d_clk = counter[20];

always @ (posedge d_clk)
begin
	if (rst)
		out_r<=12'd1;
		
	else if (COUNT == 4'b0001) //left to right
		begin
			if (flag == 0)
				begin
				out_r<=12'd1;
				flag =1;			
				end
			else
				out_r <= {out_r[0],out_r[11:1]} ;				
		end
	
	else if (COUNT == 4'b0010) //
		begin
			if (flag == 0)
				begin
				out_r<=12'b111111111110;
				flag =1;			
				end
			else
				out_r <= {out_r[0],out_r[11:1]};				
		end
	
	else if (COUNT == 4'b0100)
		begin
			if (flag == 0)
				begin
				out_r <= 12'b000001100000;
				flag =1;
				end
			else
				out_r <= {out_r[10:6],out_r[11],out_r[0],out_r[5:1]};				
		end	
		
	else // COUNT == 4'b0000
		begin
			flag = 0;
			out_r <= out_r;
		end
end

	
assign out[11:0] = out_r[11:0];

endmodule
