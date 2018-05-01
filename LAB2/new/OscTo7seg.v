module OscTo7seg(
	input clk,
	input rst,
	input [3:0] button,
	output a,
	output b,
	output c,
	output d,
	output e,
	output f,
	output g,
	output dp,
	output [5:0]seg7_decode); 

reg [7:0] seg7_display;
reg [27:0] COUNT;
reg [2:0] cnt, cnt1;

wire [3:0] flag;
wire d_clk,d_clk1;

assign seg7_decode=~6'b000001;

always @(posedge rst or posedge clk) 
begin
	if(rst)
		COUNT <= 28'd0;
	else
        COUNT <= COUNT + 1; 
end
		  
assign d_clk=COUNT[24];


always@(posedge rst or posedge d_clk)
begin
	if(rst)
		cnt<=3'd0;
	else if(cnt==3'd7)
		cnt<=3'd0;
	else
		cnt<=cnt+1'b1;
end

assign flag=cnt;

always@(flag)
begin
  case(flag)
 3'b000 :
   begin
     seg7_display<=8'b11111100;
   end
 3'b001 :
   begin
     seg7_display<=8'b01100000;
   end
 3'b010 :
   begin
     seg7_display<=8'b11011010;
   end
 3'b011 :
   begin
    seg7_display<=8'b11110010;
   end
 3'b100 :
   begin
    seg7_display<=8'b01100110;
   end
 3'b101 :
   begin
    seg7_display<=8'b10110110; 
   end
 3'b110 :
   begin
    seg7_display<=8'b10111110;
   end
 3'b111 :
   begin
     seg7_display<=8'b11100100;
	  end

 default: 
   begin
     seg7_display<=8'b11101110;
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