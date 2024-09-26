module MEF_testbench();

    // Definir las señales de prueba
    logic clk, rst;
    logic I, T, W, A;
    logic [3:0] estado;
    logic vgaclk, hsync, vsync, sync_b, blank_b;
    logic [7:0] r, g, b;
    logic [8:0] matrix_out_MEF;
    logic load;

    // Instanciar el módulo MEF
    MEF uut (
        .clk(clk),
        .rst(rst),
        .I(I),
        .T(T),
        .W(W),
        .A(A),
        .estado(estado),
        .vgaclk(vgaclk),
        .hsync(hsync),
        .vsync(vsync),
        .sync_b(sync_b),
        .blank_b(blank_b),
        .r(r),
        .g(g),
        .b(b),
        .matrix_out_MEF(matrix_out_MEF),
        .load(load)
    );

    // Generador de reloj (50 MHz, periodo de 20 ns)
    always #10 clk = ~clk;

    // Inicialización y secuencia de prueba
    initial begin
        // Inicialización
        clk = 0;
        rst = 1;
        I = 0;
        T = 0;
        W = 1;
        A = 0;
        #25 rst = 0;  // Desactivar reset después de 25 ns

        // Transición al estado S1 (cambio a estado S1 con I)
            // Activar I para seleccionar posición de la matriz
        //#20 I = 0;    // Desactivar I
        
        // Confirmar selección y modificar la matriz con W
        #30 W = 0;    // Activar W para confirmar la selección y cargar la matriz
		  #20 W = 1; 
//		  #30 W = 1;
//		  #20 W = 0; 
//		  #30 W = 1;
//        #20 W = 0;    // Desactivar W

		  
		  #20 I = 1;
		  #20 I = 0;
		   #30 W = 0;    // Activar W para confirmar la selección y cargar la matriz
		  #20 W = 1; 
		  #20 I = 1;
		  #20 I = 0;
        // Mantener el estado por un tiempo y verificar la salida de la matriz
        #40 T = 1;    // Volver a S0
        #20 T = 0;    // Desactivar T

        // Verificar el comportamiento de la matriz en S1
        $display("Matrix after modification in S1: %b", matrix_out_MEF);
        
        // Finalizar simulación
        #100 $stop;
    end

endmodule
