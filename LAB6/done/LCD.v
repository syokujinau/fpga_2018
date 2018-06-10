`timescale 1ns / 1ps

module LCD(input clk, input nrst, output LCD_RW, output LCD_EN,output LCD_RS, output [7:0]LCD_DATA
    , output [2:0] KPD_R, input [3:0] KPD_C);

// keypad setting /////////////

reg [28:0]counter;

always @(posedge clk)
begin
	counter <= counter+1'b1;
end

always@(posedge counter[20] or negedge rst )
begin
	if(~rst)
		KPD_R<= 3'b110;
	else if(KPD_C==4'b1111)
		KPD_R <= {KPD_R[1:0],KPD_R[2]};
	else
		KPD_R <= KPD_R;
end

///////////////////////////////

//DIVIDE
reg [25:0]clk_cnt;
reg o_CLK;

parameter div_number = 5000; //100000ns
parameter div_unmber_half = div_number/2;

always @(posedge clk or negedge nrst)begin
clk_cnt <= (!nrst)?0:(clk_cnt==(div_number-1))?0:clk_cnt+1'b1;
end
always @(posedge clk)begin
o_CLK <=(clk_cnt < div_unmber_half)?0:1;
end


//LCDM_CNT
reg [5:0] cnt;
reg LCD_RWr, LCD_RSr;
reg [7:0] LCD_DATAr;

assign LCD_RW = LCD_RWr;
assign LCD_RS = LCD_RSr;
assign LCD_DATA = LCD_DATAr;

//en
wire LCDM_CLK;
assign LCDM_CLK = o_CLK;
assign LCD_EN = LCDM_CLK;


    
always@(posedge LCDM_CLK or negedge nrst)begin

	if(!nrst)begin
		cnt <= 6'd0; 
	end
	else if(cnt < 6'd37) begin
		cnt <= cnt + 1'd1;
	end
	else begin
		cnt <= 6'd4; 
	end
	
    if(!nrst)begin
		LCD_RWr <= 1'b0;
		LCD_RSr <= 1'b0;
		LCD_DATAr <= 8'd0; 
	end
	else begin
	
		case(cnt)
			6'd0: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h38;end
			6'd1: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h01;end
			6'd2: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h06;end
			6'd3: begin LCD_RSr <= 1'b0; LCD_DATAr <= 8'h0C;end
			6'd4:begin
				 LCD_RSr <= 1'b0;
				 LCD_DATAr <= 8'h80;
				end
			6'd5:begin
				 LCD_RSr <= 1'b1;
				 LCD_DATAr <= " ";
				end
			6'd6:  begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd7:  begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd8:  begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd9:  begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd10: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd11: begin LCD_RSr <= 1'b1; LCD_DATAr <= a;  end
			6'd12: begin LCD_RSr <= 1'b1; LCD_DATAr <= "-";end
			6'd13: begin LCD_RSr <= 1'b1; LCD_DATAr <= b;  end
			6'd14: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd15: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd16: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd17: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd18: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd19: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd20: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd21:begin
				 LCD_RSr <= 1'b0;
				 LCD_DATAr <= 8'hC0;
				end
			6'd22:begin
				 LCD_RSr <= 1'b1;
				 LCD_DATAr <= " ";
				end
			6'd23: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd24: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd25: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd26: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd27: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd28: begin LCD_RSr <= 1'b1; LCD_DATAr <= "=";end
			6'd29: begin LCD_RSr <= 1'b1; LCD_DATAr <= c;  end
			6'd30: begin LCD_RSr <= 1'b1; LCD_DATAr <= d;  end
			6'd31: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd32: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd33: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd34: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd35: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd36: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			6'd37: begin LCD_RSr <= 1'b1; LCD_DATAr <= " ";end
			default: begin
					LCD_RSr <= LCD_RSr; LCD_DATAr <= LCD_DATAr; end
			endcase
		end
	end

//*******************************
reg [7:0] a; 
reg [7:0] b;
reg [7:0] c;
reg [7:0] d;

reg [1:0] state;

always @(posedge clk or negedge nrst) begin
	if (!nrst) begin
		state <= 2'd1;
	end
	else begin
		state <= state;
	end
end

always @(state) begin
	case(state)
		2'd0 : begin
			a = 8'h30; 
	        b = 8'h30;
	        c = 8'h30;
	        d = 8'h30;
		end

		2'd1: begin //wait first number
			a = click1;
		end 

		2'd2: begin //wait second number

		end 

		2'd3: begin //print answer

		end 



		default: begin
			a = 8'h31;  
	        b = 8'h31;
	        c = 8'h31;
	        d = 8'h31;
		end
	endcase
end

always @(*) begin
	case({KPD_R,KPD_C})
	7'b011_0111:begin end //0
	7'b110_1110:begin end //1
	7'b110_1101:begin end //2
	7'b110_1011:begin end //3
	7'b101_1110:begin end //4
	7'b101_1101:begin end //5
	7'b101_1011:begin end //6
	7'b011_1110:begin end //7
	7'b011_1101:begin end //8
	7'b011_1011:begin end //9
	7'b110_0111:begin end //10
	7'b101_0111:begin end //11
	default:
	begin 
	//out_r = 12'b000000000000; 
	//seg7_display = seg7_temp;
	end
	endcase
end

//*******************************
	
endmodule
