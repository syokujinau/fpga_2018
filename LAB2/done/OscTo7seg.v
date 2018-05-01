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
	output [5:0]seg7_decode,

  output [11:0] out           ////
); 

reg [7:0] seg7_display;
reg [27:0] COUNT;
reg [3:0] cnt;
reg [7:0] cnt1;         ////
reg [11:0] out_r;       ////
 

wire [3:0] flag;
wire d_clk,d_clk1;

assign seg7_decode=~6'b000001;
assign out = out_r;   ////
 
always@(button or clk) begin ////
	if(button == 4'b1110)
		cnt1 = 8'd20;
	else
		cnt1 = 8'd24;
end

always @(posedge rst or posedge clk) 
begin
	if(rst)
	 COUNT <= 28'd0;
	else
    COUNT <= COUNT + 1; 
end
		  
//assign d_clk=COUNT[24];
assign d_clk=COUNT[cnt1]; ////


always@(posedge rst or posedge d_clk)
begin
	if(rst)
		cnt<=4'd0;
	else if(cnt==4'd9)
		cnt<=4'd0;
	else
		cnt<=cnt+1'b1;
end

assign flag=cnt;

always@(flag)
begin
  case(flag)
 4'd0 :
   begin
     seg7_display<=8'b11111100;
     out_r <= 12'b0000_0000_0001 ;
   end
 4'd1 :
   begin
     seg7_display<=8'b01100000;
     out_r <= 12'b0000_0000_0011 ;
   end
 4'd2 :
   begin
     seg7_display<=8'b11011010;
     out_r <= 12'b0000_0000_0111 ;
   end
 4'd3 :
   begin
    seg7_display<=8'b11110010;
    out_r <= 12'b0000_0000_1111 ;
   end
 4'd4 :
   begin
    seg7_display<=8'b01100110;
    out_r <= 12'b0000_0001_1111 ;
   end
 4'd5 :
   begin
    seg7_display<=8'b10110110; 
    out_r <= 12'b0000_0011_1111 ;
   end
 4'd6 :
   begin
    seg7_display<=8'b10111110;
    out_r <= 12'b0000_0111_1111 ;
   end
 4'd7 :
   begin
     seg7_display<=8'b11100100;
     out_r <= 12'b0000_1111_1111 ;
	  end
 4'd8 :
   begin
     seg7_display<=8'b11111110;
     out_r <= 12'b0001_1111_1111 ;
   end
 4'd9 :
   begin
     seg7_display<=8'b11100110;
     out_r <= 12'b0011_1111_1111 ;
   end

 default: 
   begin
     seg7_display<=8'b11101110;
     out_r <= 12'b0000_0000_0000 ;
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