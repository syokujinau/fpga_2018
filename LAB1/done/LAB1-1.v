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
			out_r=12'b0000_0000_0000;
		else if (COUNT==4'b0001)
			out_r=12'b0000_0001_0001;	
		else if (COUNT==4'b0010)
			out_r=12'b0000_0010_0010;	
		else if (COUNT==4'b0011)
			out_r=12'b0000_0011_0011;	
		else if (COUNT==4'b0100)
			out_r=12'b0000_0100_0100;
		else if (COUNT==4'b0101)
			out_r=12'b0000_0101_0101;	
		else if (COUNT==4'b0110)
			out_r=12'b0000_0110_0110;
		else if (COUNT==4'b0111)
			out_r=12'b0000_0111_0111;	
		else if (COUNT==4'b1000)
			out_r=12'b0000_1000_1000;
		else if (COUNT==4'b1001)
			out_r=12'b0000_1001_1001;	
		else if (COUNT==4'b1010)
			out_r=12'b0001_0000_1010;
		else if (COUNT==4'b1011)
			out_r=12'b0001_0001_1011;
		else if (COUNT==4'b1100)
			out_r=12'b0001_0010_1011;
		else if (COUNT==4'b1101)
			out_r=12'b0001_0011_1011;
		else if (COUNT==4'b1110)
			out_r=12'b0001_0100_1011;			
		else
			out_r=12'b0001_0101_1111;
	end

assign out[11:0]=out_r[11:0];

endmodule
