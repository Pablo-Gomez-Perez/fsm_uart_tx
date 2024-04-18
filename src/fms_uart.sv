parameter FREQ = 27000000;
parameter BAUD = 115200;
parameter CLKS = FREQ / BAUD;


module tx_uart(input logic clk, rst, output logic tx);
	
	parameter IDLE = 0;
	parameter SEND = 1;
	parameter start_bit = 0; 
	parameter stop_bit = 0;
	
	logic [7:0] data = 8'h41;
	logic [7:0] trama;

endmodule

