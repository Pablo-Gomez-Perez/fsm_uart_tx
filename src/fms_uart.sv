/**
	cada pulso envía el siguiente caracter A.
	-cuando no hay transmición, cuando se está en un estado inactivo
	 la salida de tx debe estár a uno lógico, pues así lo marca el protocolo
	 UART.
	-cada uno de los bits debe ternet un tiempo de frecuencia, en este caso son
	 27 mll / 115 K.
	-utilizamos dos contadores internos
		~cont_8[3:0]: un contador que cuenta cuantos bits se van a transmitir
					  se transmite del 0 al 9, es decir 10 bits
		~ otro que cuenta cuantos bit son necesarios por cada bit transmitido
		  cuenta de 0 a 234
	
	-se usa el pin 17 para sacar el dato desde la computadora, el caracter A
	 corresponde a un 41 en hexadecimal dentro de la tabla de codigo Asccii
	
	-
*/

/*
	Constantes utilizadas
*/
parameter FREQ = 27000000; //Hz
parameter BAUD = 115200; 
parameter CLKS = FREQ / BAUD; //Velocidad de transmisión del módulo


/**
 * Modulo Principal Top 
 */
module tx_uart(input logic clk, rst, output logic tx);
	
	parameter IDLE = 0;
	parameter SEND = 1;
	parameter start_bit = 0; 
	parameter stop_bit = 0;
	
	logic [7:0] data = 8'h41;
	logic [7:0] trama;

endmodule

