module Main (
    input logic clk, rst, I, T, W, A, B, Z, J1, J2, C,
    output logic [3:0] estado,  // Salida de estado de la MEF
    output logic vgaclk, hsync, vsync, sync_b, blank_b,  // Señales VGA
    output logic [7:0] r, g, b,  // Señales de color VGA
    output logic [17:0] matrix_out_MEF,  // Salida de la matriz modificada
    output logic load,  // Señal de carga de la matriz
    output logic finished,  // Señal que indica que el contador ha llegado a 15 segundos
	 output logic G1,G2,
    output logic [6:0] seg1,  // Segmentos del primer display de 7 segmentos
    output logic [6:0] seg2,   // Segmentos del segundo display de 7 segmentos
	 
	 input wire miso,          // Master In, Slave Out (desde el esclavo)
    output wire mosi,         // Master Out, Slave In (hacia el esclavo)
    output wire sclk,         // Reloj SPI
    output wire ss           // Selección del esclavo
);

    logic [9:0] x, y;
    logic [7:0] r_PantallaInicial, g_PantallaInicial, b_PantallaInicial; 
    logic [7:0] r_PantallaJugadores, g_PantallaJugadores, b_PantallaJugadores;
	 logic [7:0] r_PantallaGJ1, g_PantallaGJ1, b_PantallaGJ1;
	 logic [7:0] r_PantallaGJ2, g_PantallaGJ2, b_PantallaGJ2;
	 logic [7:0] r_PantallaPJ1, g_PantallaPJ1, b_PantallaPJ1;
    logic [7:0] r_videoGen, g_videoGen, b_videoGen;  
    logic [7:0] r_black, g_black, b_black;  
    logic [3:0] count;
    logic [17:0] matrix_in, matrix_reg;
	 logic [5:0] index1;
	 logic start_signal;
	 
	 

    // Instancia del contador
    TopCounter counter_inst (
        .clk(clk),
        .rst(rst),
		  .next_state(next_state),
        .current_state(estado),  // Estado actual de la MEF
        .finished(finished),  // Señal de finished desde el contador
        .count(count)
    );
	 
	 Debounce debounce_inst (
			 .pb_1(W),       // Botón de entrada a debouncing (ejemplo: Z)
			 .clk(clk),      // Señal de reloj global
			 .pb_out(Wdebounced) // Señal de salida debounced
		);
		Debounce debounce_inst1 (
			 .pb_1(Z),       // Botón de entrada a debouncing (ejemplo: Z)
			 .clk(clk),      // Señal de reloj global
			 .pb_out(Zdebounced) // Señal de salida debounced
		);

    // Instancia de la MEF, usando la señal finished del contador como entrada
    MEF mef_inst (
        .clk(clk),
        .rst(rst),
        .T(T),
        .I(I),
        .B(B),
        .A(A),
        .J1(J1),
		  .J2(J2),
		  .G1(G1),
		  .G2(G2),
		  .C(C),
        .finished(finished),  // Conectar la salida finished del contador como entrada aquí
        .estado(estado),
		  .next_state(next_state)
    );

    // Instancia de PLL para generar la señal de 25.175 MHz para el VGA
    pll vgapll(.inclk0(clk), .c0(vgaclk));

    // Instancia del controlador VGA
    vgaController vgaCont(
        .vgaclk(vgaclk), 
        .hsync(hsync), 
        .vsync(vsync), 
        .sync_b(sync_b), 
        .blank_b(blank_b), 
        .x(x), 
        .y(y)
    );

    // Instancia del módulo Pantalla_Inicial
    Pantalla_Inicial pantallaInicial(
        .x(x), 
        .y(y), 
        .r(r_PantallaInicial), 
        .g(g_PantallaInicial), 
        .b(b_PantallaInicial)
    );

    // Instancia del controlador de displays
    DisplayController display_inst (
        .bin(count),
        .seg1(seg1),
        .seg2(seg2)
    );

    // Instancia del módulo videoGen
    videoGen vgagen(
        .x(x), 
        .y(y), 
        .matrix(matrix_out_MEF), 
		  .Id(Id),
        .r(r_videoGen), 
        .g(g_videoGen), 
        .b(b_videoGen)
    );

    // Instancia del módulo matrixControl
    matrixControl u_matrixControl (
        .clk(clk), 
        .rst_n(!rst), 
        .I(I), 
        .W(!Wdebounced), 
		  .B(B),
		  .Z(!Zdebounced),
		  .finished(finished),
        .matrix_in(matrix_reg), 
        .matrix_out(matrix_in), 
		  .current_state(estado),
        .load(load),
		  .indexOut(index1)
    );

    // Instancia del módulo matrixRegister
    matrixRegister u_matrixRegister (
        .clk(clk), 
        .rst_n(!rst), 
        .data_in(matrix_in), 
        .load(load), 
        .matrix(matrix_reg)
    );
	 Pantalla_Jugadores pantalla_jugadores_inst (
        .x(x),
        .y(y),
        .r(r_PantallaJugadores),
        .g(g_PantallaJugadores),
        .b(b_PantallaJugadores)
    );
	 
	 Victoria victory(
		  .clk(clk),
		  .rst_n(!rst),
		  .matrix(matrix_out_MEF),
		  .G1(G1),
		  .G2(G2)
		  );
<<<<<<< HEAD
	 Pantalla_Gano_J1 pantalla_gano_j1 (
		 .x(x),        // Coordenadas de píxel actual en X
		 .y(y),        // Coordenadas de píxel actual en Y
		 .r(r_PantallaGJ1),        // Salida de componente roja del color RGB
		 .g(g_PantallaGJ1),        // Salida de componente verde del color RGB
		 .b(b_PantallaGJ1)         // Salida de componente azul del color RGB
	  );
	  Pantalla_Gano_J2 pantalla_gano_j2 (
		 .x(x),        // Coordenadas de píxel actual en X
		 .y(y),        // Coordenadas de píxel actual en Y
		 .r(r_PantallaGJ2),        // Salida de componente roja del color RGB
		 .g(g_PantallaGJ2),        // Salida de componente verde del color RGB
		 .b(b_PantallaGJ2)         // Salida de componente azul del color RGB
	);

	 Pantalla_Perdio_J1 pantalla_perdio_J1 (
		 .x(x),        // Coordenadas de píxel actual en X
		 .y(y),        // Coordenadas de píxel actual en Y
		 .r(r_PantallaPJ1),        // Salida de componente roja del color RGB
		 .g(g_PantallaPJ1),        // Salida de componente verde del color RGB
		 .b(b_PantallaPJ1)         // Salida de componente azul del color RGB
	);

=======
		  
	 spiMaster spi_master_inst (
        .clk(clk),                 // Conectado al reloj del sistema
        .rst_n(!rst),             // Reset activo en bajo
        .start( load),    // Señal para iniciar la transferencia
        .move_index(index1),   // Índice de jugada de 5 bits
        .done(done),               // Señal de finalización de transferencia
        .received_data(received_data), // Dato recibido del Arduino
		  .mosi(mosi),                 // Señal mosi (Master Out, Slave In)
        .miso(miso),                 // Señal miso (Master In, Slave Out)
        .sclk(sclk),                 // Reloj SPI
        .ss(ss),                     // Selección del esclavo
    );
>>>>>>> bc8efb8efd8a963fcc7cf14147405db2ffe858f3

    assign matrix_out_MEF = matrix_reg;

    // Multiplexor para seleccionar la imagen a mostrar
    always_comb begin
        case (estado)
            4'b0000: begin
                r = r_PantallaInicial;
                g = g_PantallaInicial;
                b = b_PantallaInicial;
            end
            4'b0001: begin
                r = r_videoGen;
                g = g_videoGen;
                b = b_videoGen;
            end
            4'b0010: begin
                r = r_videoGen;
                g = g_videoGen;
                b = b_videoGen;
            end
				4'b0011: begin
                r = r_PantallaGJ1;
                g = g_PantallaGJ1;
                b = b_PantallaGJ1;
            end
				
				4'b0100: begin
					r= r_PantallaPJ1;        
					g= g_PantallaPJ1;        
					b= b_PantallaPJ1;
				end
				4'b0101: begin
                r = r_PantallaJugadores;
                g = g_PantallaJugadores;
                b = b_PantallaJugadores;
            end
				
            4'b0110: begin
                r = r_videoGen;
                g = g_videoGen;
                b = b_videoGen;
            end
            4'b0111: begin
                r = r_videoGen;
                g = g_videoGen;
                b = b_videoGen;
            end
				4'b1000: begin
                r = r_PantallaGJ1;
                g = g_PantallaGJ1;
                b = b_PantallaGJ1;
            end
				4'b1001: begin
                r = r_PantallaGJ2;
                g = g_PantallaGJ2;
                b = b_PantallaGJ2;
            end
				
				
				
            default: begin
                r = 8'b00000000;
                g = 8'b00000000;
                b = 8'b00000000;
            end
        endcase
    end

endmodule