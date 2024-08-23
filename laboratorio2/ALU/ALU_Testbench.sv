module ALU_Testbench;

    // Parámetros
    parameter N = 8;

    // Entradas y salidas
    logic [N-1:0] a, b;
    logic [N-1:0] andResult, orResult, xorResult;
    logic [N-1:0] sllResult, srlResult, divResult, modResult;
    logic zeroFlag, negativeFlag;

    // Instancia de la ALU
    ALU #(N) uut (
        .a(a),
        .b(b),
        .andResult(andResult),
        .orResult(orResult),
        .xorResult(xorResult),
        .sllResult(sllResult),
        .srlResult(srlResult),
        .divResult(divResult),
        .modResult(modResult),
        .zeroFlag(zeroFlag),
        .negativeFlag(negativeFlag)
    );

    // Proceso de prueba
    initial begin
        // Prueba 1: AND lógico
        a = 8'b11001100;
        b = 8'b10101010;
        #10;  // Espera para permitir que la operación se realice
        $display("AND Result: %b, Zero Flag: %b, Negative Flag: %b", andResult, zeroFlag, negativeFlag);

        // Prueba 2: OR lógico
        a = 8'b00001111;
        b = 8'b11110000;
        #10;
        $display("OR Result: %b, Zero Flag: %b, Negative Flag: %b", orResult, zeroFlag, negativeFlag);

        // Prueba 3: XOR lógico
        a = 8'b10101010;
        b = 8'b01010101;
        #10;
        $display("XOR Result: %b, Zero Flag: %b, Negative Flag: %b", xorResult, zeroFlag, negativeFlag);

        // Prueba 4: Shift left logical (desplazamiento lógico a la izquierda)
        a = 8'b00001111;
        b = 8'd1;  // Desplazar a la izquierda por 1
        #10;
        $display("Shift Left Result: %b, Zero Flag: %b, Negative Flag: %b", sllResult, zeroFlag, negativeFlag);

        // Prueba 5: Shift right logical (desplazamiento lógico a la derecha)
        a = 8'b10000000;
        b = 8'd1;  // Desplazar a la derecha por 1
        #10;
        $display("Shift Right Result: %b, Zero Flag: %b, Negative Flag: %b", srlResult, zeroFlag, negativeFlag);

        // Prueba 6: División
        a = 8'd100;
        b = 8'd5;
        #10;
        $display("División Result: %d, Zero Flag: %b, Negative Flag: %b", divResult, zeroFlag, negativeFlag);

        // Prueba 7: Módulo
        a = 8'd100;
        b = 8'd30;
        #10;
        $display("Módulo Result: %d, Zero Flag: %b, Negative Flag: %b", modResult, zeroFlag, negativeFlag);

        // Prueba 8: Operación con resultado cero
        a = 8'b00000000;
        b = 8'b00000000;
        #10;
        $display("Operación Cero - AND Result: %b, Zero Flag: %b, Negative Flag: %b", andResult, zeroFlag, negativeFlag);

        // Prueba 9: Operación con resultado negativo (bit más significativo en 1)
        a = 8'b10000000;
        b = 8'b00000001;
        #10;
        $display("Operación Negativa - AND Result: %b, Zero Flag: %b, Negative Flag: %b", andResult, zeroFlag, negativeFlag);

        // Finalizar la simulación
        $finish;
    end

endmodule
