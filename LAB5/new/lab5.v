module lab5(a,b,c,d,e,f,g,dp,seg7_decode,clk,start);

output a,b,c,d,e,f,g,dp;  /* 7-segment output */
output [5:0] seg7_decode; /* Scan signal for 7-segment */
input clk;                /* Original clock */
input start;              /* Start */ 

reg  [7:0] seg7_display;
reg  [5:0] seg7_decode;

reg [24:0] counter;
reg [3:0] state;
reg [3:0] seg1,seg2;

//reg [2:0] sel;

always @(posedge clk) //Original clock is so fast!
begin
	counter[24:0] <= counter[24:0] + 1'b1;	
end

always@(posedge counter[24])//clock divied
begin

	if(start==0)
	begin
		seg1<=0;
		seg2<=0;
	end
	else
   begin
		if(seg2 < 4'd9)  //counter(00~99)
		begin
			seg2<=seg2+4'd1;
			seg1<=seg1;
		end
		else
		begin
			seg2<=4'd0;
			if(seg1 < 4'd9)
			begin
				seg1<=seg1+4'd1;
			end
			else
			begin
				seg1<=4'd0;
			end
		end
   end
	
end


always@(posedge counter[10]) //clock divied
begin
	//scan signal for 7-segment --1
	
	if(seg7_decode==0) 
	   seg7_decode<=~6'b000001;
	else
		seg7_decode[5:0] <={seg7_decode[4:0],seg7_decode[5]};
	
	
	//scan signal for 7-segment --2
	/*
	if(~seg7_decode==0) 
	  begin
	    seg7_decode<=~6'b000001;
	    sel<=0;
	  end
   else
	  case(sel)
	  3'd0: begin sel<=3'd1; seg7_decode<=~6'b000001;end
	  3'd1: begin sel<=3'd2; seg7_decode<=~6'b000010;end
	  3'd2: begin sel<=3'd3; seg7_decode<=~6'b000100;end
	  3'd3: begin sel<=3'd4; seg7_decode<=~6'b001000;end
	  3'd4: begin sel<=3'd5; seg7_decode<=~6'b010000;end
	  3'd5: begin sel<=3'd0; seg7_decode<=~6'b100000;end
	  default: 
	        begin sel<=3'd0; seg7_decode<=~6'b000001;end
	  endcase
	  */

	
end

always@(seg7_decode,seg1,seg2)
begin

  case(~seg7_decode)
  6'b000001: begin state=seg2;end
  6'b000010: begin state=seg1;end
  6'b000100: begin state=4'hF;end
  6'b001000: begin state=4'hF;end
  6'b010000: begin state=4'hF;end
  6'b100000: begin state=4'hF;end
  default:   begin state=4'hF;end//No Light 
  endcase

end


always@(state)//Number Display for 7-segment 
begin
	case(state)
   4'd0:begin seg7_display=8'b11111100; end//0
   4'd1:begin seg7_display=8'b01100000; end//1
   4'd2:begin seg7_display=8'b11011010; end//2 
   4'd3:begin seg7_display=8'b11110010; end//3
   4'd4:begin seg7_display=8'b01100110; end//4 
   4'd5:begin seg7_display=8'b10110110; end//5
   4'd6:begin seg7_display=8'b10111110; end//6 
   4'd7:begin seg7_display=8'b11100000; end//7
   4'd8:begin seg7_display=8'b11111110; end//8 
   4'd9:begin seg7_display=8'b11110110; end//9     
   default:begin seg7_display=8'b00000000;end//No Light 
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

