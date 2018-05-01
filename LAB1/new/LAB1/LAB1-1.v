module TestLED(out,inpulse);
output [11:0] out;
input [3:0] inpulse;

reg [3:0] COUNT;
reg [11:0] out_r;

always @ (inpulse)
	COUNT=~inpulse;
	
always @ (COUNT)
	begin
		if (COUNT==4'b0000)
			out_r=12'b1000_0000_0000;
		else if (COUNT==4'b0001)
			out_r=12'b0100_0000_0000;	
		else if (COUNT==4'b0010)
			out_r=12'b0010_0000_0000;	
		else if (COUNT==4'b0011)
			out_r=12'b0001_0000_0000;	
		else if (COUNT==4'b0100)
			out_r=12'b0000_1000_0000;
		else if (COUNT==4'b0101)
			out_r=12'b0000_0100_0000;	
		else if (COUNT==4'b0110)
			out_r=12'b0000_0010_0000;
		else if (COUNT==4'b0111)
			out_r=12'b0000_0001_0000;	
		else if (COUNT==4'b1000)
			out_r=12'b0000_0000_1000;
		else if (COUNT==4'b1001)
			out_r=12'b0000_0000_0100;	
		else if (COUNT==4'b1010)
			out_r=12'b0000_0000_0010;
		else if (COUNT==4'b1011)
			out_r=12'b0000_0000_0001;	
		else
			out_r=12'b1111_11111_1111;
	end

assign out[11:0]=out_r[11:0];

endmodule
