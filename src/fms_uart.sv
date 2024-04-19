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
	
	/*
	parameter IDLE = 0;
	parameter SEND = 1;
	parameter start_bit = 0; 
	parameter stop_bit = 0;
	
	logic [7:0] data = 8'h41;
	logic [7:0] trama;
	*/
	parameter IDLE = 0;
	parameter SEND = 1;
	parameter bit_de_inicio = 0;
	parameter bit_de_parada = 1;

	//Cables empleados para las conexiones
	logic [15:0] conta; //para el contador
	logic pulsito;		//para el generador de pulsos
	logic [7:0] dato_tx = 8'h41;  //corresponde al caracter 'A' en ASCII
	logic [9:0] trama;
	logic estado = IDLE;
	logic siguiente_estado = IDLE;
	logic [15:0] conta_tx;
	logic [3:0] conta_8;
	
	//reset
	always_ff@(posedge clk, negedge rst)
	if(!rst) estado <= IDLE;
	else estado <= siguiente_estado;

	//se asigna el valor de la salida tx
	assign tx = (siguiente_estado == IDLE) ? 1'b1 : trama[0];
	
	//Generador de pulsos pulsito
	always_ff@(posedge clk, negedge rst)
	if(!rst) conta <= 0;
	else if(conta == 16'd3000)
	begin
		pulsito <= 1;
		conta <= 0;
	end
	else
	begin
		pulsito <= 0;
		conta <= conta + 1;
	end	

	//====================================
	//se definen las configuraciones de los dos estados
	always_ff@(posedge clk)
	case(estado)
	IDLE: 
		if(pulsito)
		begin
			trama <= {1'b1,dato_tx,1'b0};
			siguiente_estado <= SEND;
		end
		else siguiente_estado <= siguiente_estado;
	SEND: 
		if(conta_tx == CLKS && conta_8 == 4'd9)
		begin
			siguiente_estado <= IDLE;
		end
		else
		begin
			if(conta_tx == CLKS)
			begin
				siguiente_estado <= SEND;
				trama <= {1'b1,trama[9:1]};
			end
			else trama <= trama;
		end
	endcase
	
	always_ff@(posedge clk)
	if(estado == IDLE) conta_8 <= 0;
	else
	begin
		if(conta_tx == CLKS)
		begin
			if(conta_8 == 4'd9) conta_8 <= 0;
			else conta_8 <= conta_8 + 1;
		end
		else conta_8 <= conta_8;
	end

	//contador general hasta los 234
	always_ff@(posedge clk)
	if(estado == IDLE) conta_tx <= 0;
	else if(conta_tx == CLKS) conta_tx <= 0;
	else conta_tx <= conta_tx + 1;

endmodule


