`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:19:07 05/27/2016 
// Design Name: 
// Module Name:    uart 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module UART(nRST,Baud_CLK,RXD,OUTPUT);

input Baud_CLK;
input nRST;
//output TXD;
input RXD;

reg [7:0] OUT;
output reg [7:0] OUTPUT; // to LCD input rx_data


//reg TXD;
wire [135:0] data_tmp;
//8'h0a換行, 8'h0d游標回到最左
assign data_tmp={8'h0a,8'h0d,"T","S","E","T","",8'h0a,8'h0d,"+","A","G","P","F","r","o","M"};

reg[3:0]uart_state; 
reg[9:0]data_tmp_bit;
reg[9:0]data_len;
reg[2:0]word_bit;
//reg txd1;
reg[15:0]delay;
`define IDLE 4'd0
`define START_BIT 4'd1
`define DATA_BIT 4'd2
`define EDN_BIT1 4'd3
`define EDN_BIT2 4'd4
`define Wait     4'd5
always@(posedge Baud_CLK or negedge nRST)begin

    if(!nRST)begin
      uart_state<=`IDLE;
      //txd1<=1'b1;//1'b1 狀態為不傳送     
	    data_tmp_bit<=10'd0;
      word_bit<=3'd0;
      data_len<=10'd136;
      delay      <=16'd0;
   end
   else begin
     case(uart_state)
        `IDLE:begin
         if(delay==16'd38400)begin
            uart_state<=`START_BIT;
            delay     <= 0;
         end
         else begin
            uart_state<=`IDLE;
            delay<=delay+1'b1;
         end
        end 
   
        `START_BIT:begin
          //txd1 <= 1'b0;//1'b0 狀態為傳送    
          uart_state<=`DATA_BIT;
        end

        `DATA_BIT:begin
          // txd1<=data_tmp[data_tmp_bit];
          if(word_bit==3'd7)begin
            OUT[data_tmp_bit] <= RXD;   /////////
            word_bit<=3'd0;
            uart_state<=`EDN_BIT1; 
            data_tmp_bit<=data_tmp_bit+1'b1;
          end
          else begin
            OUT[data_tmp_bit] <= RXD;  //////////
            data_tmp_bit<=data_tmp_bit+1'b1;
            uart_state<=`DATA_BIT;
            word_bit<=word_bit+1'b1;
          end
        end

        `EDN_BIT1:begin
          //txd1<=1'b1;
          OUTPUT <= OUT;
          uart_state<=`EDN_BIT2;
        end

        `EDN_BIT2:begin
          //txd1<=1'b1;
          if(data_tmp_bit==data_len)begin
            uart_state<=`Wait;
            data_tmp_bit<=10'd0;
          end
          else begin
            uart_state<=`START_BIT;
          end
        end
  				
        `Wait:begin
          if(!nRST)begin
            uart_state<=`IDLE;
            data_tmp_bit<=0;
          end
          else begin
            uart_state<=`Wait;
          end
        end
   
     endcase 
   end
end

// always@(posedge Baud_CLK or negedge nRST)begin
//    if(!nRST)begin
//         TXD <= 1'b1;
//    end
//    else begin
//         TXD <= txd1;
//    end
// end

endmodule