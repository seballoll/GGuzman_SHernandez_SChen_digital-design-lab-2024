module multiplier_display_tb;

    // Paràmetro para definir el ancho de los operandos
    parameter N = 4;

    // Señales de entrada y salida
    logic [N-1:0] a, b;
    logic [6:0] seg1, seg2;
    logic overflow;

    // Instancia del DUT (Device Under Test)
    multiplier_display #(.N(N)) dut (
        .a(a),
        .b(b),
        .seg1(seg1),
        .seg2(seg2),
        .overflow(overflow)
    );

    // Procedimiento de estímulo inicial
    initial begin
        // Configuración inicial
        a = 4'b0000;
        b = 4'b0000;

        // Estímulo de prueba 1: 3 * 2 = 6
        #10;
        a = 4'b0011; // 3
        b = 4'b0010; // 2
        #10;
        $display("A = %b, B = %b, Resultado = %b%b (Overflow = %b)", a, b, seg2, seg1, overflow);

        // Estímulo de prueba 2: 7 * 5 = 35
        #10;
        a = 4'b0111; // 7
        b = 4'b0101; // 5
        #10;
        $display("A = %b, B = %b, Resultado = %b%b (Overflow = %b)", a, b, seg2, seg1, overflow);

        // Estímulo de prueba 3: 8 * 8 = 64 (desbordamiento esperado)
        #10;
        a = 4'b1000; // 8
        b = 4'b1000; // 8
        #10;
        $display("A = %b, B = %b, Resultado = %b%b (Overflow = %b)", a, b, seg2, seg1, overflow);

        // Estímulo de prueba 4: 15 * 15 = 225 (desbordamiento esperado)
        #10;
        a = 4'b1111; // 15
        b = 4'b1111; // 15
        #10;
        $display("A = %b, B = %b, Resultado = %b%b (Overflow = %b)", a, b, seg2, seg1, overflow);

    end

endmodule 