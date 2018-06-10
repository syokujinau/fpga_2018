// 28 states

module lab5(a,b,c,d,e,f,g,dp,seg7_decode,clk,switch0, switch1, switch2);

output a,b,c,d,e,f,g,dp;  /* 7-segment output */
output [5:0] seg7_decode; /* Scan signal for 7-segment */
input clk;                /* Original clock */
input switch0, switch1, switch2;              

reg  [7:0] seg7_display;
reg  [5:0] seg7_decode;

reg [24:0] counter;
reg [4:0] width = 5'd28;
reg [4:0] state = 5'd0;
 

parameter G_a    = 8'b1000_0000;
parameter G_ab   = 8'b1100_0000;
parameter G_ag   = 8'b1000_0010;
parameter G_abg  = 8'b1100_0010;
parameter G_g    = 8'b0000_0010;
parameter G_gd   = 8'b0001_0010;
parameter G_ge   = 8'b0000_1010;
parameter G_ged  = 8'b0001_1010;
parameter G_d    = 8'b0001_0000;
parameter G_de   = 8'b0001_1000;
parameter G_cd   = 8'b0011_0000;
parameter G_cg   = 8'b0010_0010;
parameter G_fa   = 8'b1000_0100;
parameter G_fg   = 8'b0000_0110;
parameter G_afg  = 8'b1000_0110;
parameter G_bg   = 8'b0100_0010;
parameter G_gcd  = 8'b0011_0010;
parameter G_null = 8'b0000_0000;

always @(posedge clk) //Original clock is so fast!
begin
	counter[24:0] <= counter[24:0] + 1'b1;	
end


always@(posedge counter[10]) //clock divied
begin
	//scan signal for 7-segment --1
	
	if(seg7_decode==0) 
	   seg7_decode <= ~6'b000001;
	else
		seg7_decode[5:0] <= {seg7_decode[4:0],seg7_decode[5]};

end



wire d_clk;
assign d_clk = counter[width];

always @(switch2) begin //speed up

	if(switch2 == 1) width = 5'd19;
	else             width = 5'd20;

end

always @(posedge d_clk) begin //forward or backward
	 
	if({switch1, switch0} == 2'b01) begin
		if(state == 5'd27) state <= 5'd0;
		else state <= state + 5'b1;
	end

	else if({switch1, switch0} == 2'b10)begin
		if(state == 5'd0) state <= 5'd27;
		else state <= state - 5'b1;
	end

	else  // 000
		state <= 0;
	
end







always@(seg7_decode, state)//Number Display for 7-segment 
begin
	case(~seg7_decode)
	6'b100000 : begin
					case(state)
					5'd0 : seg7_display = G_null;
					5'd1 : seg7_display = G_null;
					5'd2 : seg7_display = G_null;
					5'd3 : seg7_display = G_null;
					5'd4 : seg7_display = G_null;
					5'd5 : seg7_display = G_null;

					5'd6 : seg7_display = G_g;
					5'd7 : seg7_display = G_ge;
					5'd8 : seg7_display = G_ged;
					5'd9 : seg7_display = G_ged;
					5'd10 :seg7_display = G_ged;

					5'd11 :seg7_display = G_de;
					5'd12 :seg7_display = G_d;
					5'd13 :seg7_display = G_null;
					5'd14 :seg7_display = G_null;
					5'd15 :seg7_display = G_null;

					5'd16 :seg7_display = G_null;
					5'd17 :seg7_display = G_null;
					5'd18 :seg7_display = G_null;
					5'd19 :seg7_display = G_null;
					5'd20 :seg7_display = G_g;

					5'd21 :seg7_display = G_fg;
					5'd22 :seg7_display = G_afg;
					5'd23 :seg7_display = G_afg;
					5'd24 :seg7_display = G_afg;
					5'd25 :seg7_display = G_fa;

					5'd26 :seg7_display = G_a;
					5'd27 :seg7_display = G_null;
					default: seg7_display = G_null ;
					endcase
				end

	6'b010000 : begin
					case(state)
					5'd0 : seg7_display = G_null; 
					5'd1 : seg7_display = G_null;
					5'd2 : seg7_display = G_null;
					5'd3 : seg7_display = G_null;
					5'd4 : seg7_display = G_null;
					5'd5 : seg7_display = G_g;

					5'd6 : seg7_display = G_g;
					5'd7 : seg7_display = G_g;
					5'd8 : seg7_display = G_g;
					5'd9 : seg7_display = G_gd;
					5'd10 :seg7_display = G_d;

					5'd11 :seg7_display = G_d;
					5'd12 :seg7_display = G_d;
					5'd13 :seg7_display = G_d;
					5'd14 :seg7_display = G_null;
					5'd15 :seg7_display = G_null;

					5'd16 :seg7_display = G_null;
					5'd17 :seg7_display = G_null;
					5'd18 :seg7_display = G_null;
					5'd19 :seg7_display = G_g;
					5'd20 :seg7_display = G_g;

					5'd21 :seg7_display = G_g;
					5'd22 :seg7_display = G_g;
					5'd23 :seg7_display = G_ag;
					5'd24 :seg7_display = G_a;
					5'd25 :seg7_display = G_a;

					5'd26 :seg7_display = G_a;
					5'd27 :seg7_display = G_a;
					default: seg7_display = G_null ;
					endcase
				end

	6'b001000 : begin
					case(state)
					5'd0 : seg7_display = G_a;
					5'd1 : seg7_display = G_null;
					5'd2 : seg7_display = G_null;
					5'd3 : seg7_display = G_null;
					5'd4 : seg7_display = G_g;
					5'd5 : seg7_display = G_g;
					5'd6 : seg7_display = G_g;
					5'd7 : seg7_display = G_g;
					5'd8 : seg7_display = G_g;
					5'd9 : seg7_display = G_null;
					5'd10 :seg7_display = G_d;
					5'd11 :seg7_display = G_d;
					5'd12 :seg7_display = G_d;
					5'd13 :seg7_display = G_d;
					5'd14 :seg7_display = G_d;
					5'd15 :seg7_display = G_null;
					5'd16 :seg7_display = G_null;
					5'd17 :seg7_display = G_null;
					5'd18 :seg7_display = G_g;
					5'd19 :seg7_display = G_g;
					5'd20 :seg7_display = G_g;
					5'd21 :seg7_display = G_g;
					5'd22 :seg7_display = G_g;
					5'd23 :seg7_display = G_null;
					5'd24 :seg7_display = G_a;
					5'd25 :seg7_display = G_a;
					5'd26 :seg7_display = G_a;
					5'd27 :seg7_display = G_a;
					default: seg7_display = G_null ;
					endcase
				end

	6'b000100 : begin
					case(state)
					5'd0 : seg7_display = G_a;
					5'd1 : seg7_display = G_a;
					5'd2 : seg7_display = G_null;
					5'd3 : seg7_display = G_g;
					5'd4 : seg7_display = G_g;
					5'd5 : seg7_display = G_g;
					5'd6 : seg7_display = G_g;
					5'd7 : seg7_display = G_g;
					5'd8 : seg7_display = G_null;
					5'd9 : seg7_display = G_null;
					5'd10 :seg7_display = G_null;
					5'd11 :seg7_display = G_d;
					5'd12 :seg7_display = G_d;
					5'd13 :seg7_display = G_d;
					5'd14 :seg7_display = G_d;
					5'd15 :seg7_display = G_d;
					5'd16 :seg7_display = G_null;
					5'd17 :seg7_display = G_g;
					5'd18 :seg7_display = G_g;
					5'd19 :seg7_display = G_g;
					5'd20 :seg7_display = G_g;
					5'd21 :seg7_display = G_g;
					5'd22 :seg7_display = G_null;
					5'd23 :seg7_display = G_null;
					5'd24 :seg7_display = G_null;
					5'd25 :seg7_display = G_a;
					5'd26 :seg7_display = G_a;
					5'd27 :seg7_display = G_a;
					default: seg7_display = G_null ;
					endcase
				end

	6'b000010 : begin
					case(state)
					5'd0 : seg7_display = G_a; 
					5'd1 : seg7_display = G_a;
					5'd2 : seg7_display = G_ag;
					5'd3 : seg7_display = G_g;
					5'd4 : seg7_display = G_g;
					5'd5 : seg7_display = G_g;
					5'd6 : seg7_display = G_g;
					5'd7 : seg7_display = G_null;
					5'd8 : seg7_display = G_null;
					5'd9 : seg7_display = G_null;
					5'd10 :seg7_display = G_null;
					5'd11 :seg7_display = G_null;
					5'd12 :seg7_display = G_d;
					5'd13 :seg7_display = G_d;
					5'd14 :seg7_display = G_d;
					5'd15 :seg7_display = G_d;
					5'd16 :seg7_display = G_gd;
					5'd17 :seg7_display = G_g;
					5'd18 :seg7_display = G_g;
					5'd19 :seg7_display = G_g;
					5'd20 :seg7_display = G_g;
					5'd21 :seg7_display = G_null;
					5'd22 :seg7_display = G_null;
					5'd23 :seg7_display = G_null;
					5'd24 :seg7_display = G_null;
					5'd25 :seg7_display = G_null;
					5'd26 :seg7_display = G_a;
					5'd27 :seg7_display = G_a;
					default: seg7_display = G_null ;
					endcase
				end

	6'b000001 : begin
					case(state)
					5'd0 : seg7_display = G_ab;
					5'd1 : seg7_display = G_abg;
					5'd2 : seg7_display = G_abg;
					5'd3 : seg7_display = G_abg;
					5'd4 : seg7_display = G_bg;
					5'd5 : seg7_display = G_g;
					5'd6 : seg7_display = G_null;
					5'd7 : seg7_display = G_null;
					5'd8 : seg7_display = G_null;
					5'd9 : seg7_display = G_null;
					5'd10 :seg7_display = G_null;
					5'd11 :seg7_display = G_null;
					5'd12 :seg7_display = G_null;
					5'd13 :seg7_display = G_d;
					5'd14 :seg7_display = G_cd;
					5'd15 :seg7_display = G_gcd;
					5'd16 :seg7_display = G_gcd;
					5'd17 :seg7_display = G_gcd;
					5'd18 :seg7_display = G_cg;
					5'd19 :seg7_display = G_g;
					5'd20 :seg7_display = G_null;
					5'd21 :seg7_display = G_null;
					5'd22 :seg7_display = G_null; 
					5'd23 :seg7_display = G_null;
					5'd24 :seg7_display = G_null;
					5'd25 :seg7_display = G_null;
					5'd26 :seg7_display = G_null;
					5'd27 :seg7_display = G_a;
					default: seg7_display = G_null ;
					endcase
				end

	default : seg7_display = G_null;
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

