module TopCounter (
    input logic clk,          // Reloj global
    input logic rst,  
	 input logic [3:0] current_state,// Señal de reset
	 input logic [3:0] next_state,
    output logic finished,    // Señal que indica que el contador ha llegado a 15 segundos
    output logic [3:0] count  // Contador de 4 bits para visualizar los segundos
);

    logic [15:0] t;           // Señales de t0 de cada instancia del contador
    logic [3:0] counter15;    // Contador para sumar los pulsos de t0 (4 bits)
    logic reset_all;          // Señal para reiniciar el proceso después de 15 segundos

    // Instanciamos 15 contadores
    genvar i;
    generate
        for (i = 0; i < 16; i = i + 1) begin : counter_chain
            Counter u (
                .clk(clk),
                .rst(reset_all),    // Reseteamos todos los contadores cuando el ciclo se complete
                .t0(t[i])           // Cada contador tiene su propia salida t0
            );
        end
    endgenerate

    // Contador para sumar los pulsos de t0 y visualizar el conteo
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter15 <= 0;
            //finished <= 0;
            reset_all <= 1;  // Reseteamos todo al inicio
        end
		  
        else begin
            // Detectar cuándo se activan las señales t0
            if (|t && (current_state==4'b0001)) 
				begin
                counter15 <= counter15 + 1;  // Sumar el pulso t0
            end
				
				if (current_state != next_state)
				begin
					counter15 <= 0;
				end
				
            if (|t && (current_state==4'b0110)) 
				begin
                counter15 <= counter15 + 1;  // Sumar el pulso t0
            end
				
				if (|t && (current_state==4'b0111)) 
				begin
                counter15 <= counter15 + 1;  // Sumar el pulso t0
            end
				
            // Si el contador llega a 15, reiniciamos todo
            if (counter15 == 16) begin
                counter15 <= 0;  // Reiniciamos el contador de 15 segundos
                //finished <= 1;   // Indicamos que hemos alcanzado 15 segundos
                reset_all <= 1;  // Reiniciamos todos los contadores
            end
				if (current_state==4'b0010) begin
					counter15 <= 0;
					//finished <= 0;
					reset_all <= 1;  // Reseteamos todo al inicio
				end
				
            else begin
                //finished <= 0;
                reset_all <= 0;  // Dejar de reiniciar una vez que todos los contadores están en marcha
            end
        end
    end

    // Asignamos el valor del contador de 4 bits a la salida
    assign count = counter15;
	 assign finished = (count == 4'd15);

endmodule
