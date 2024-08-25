// Módulo del multiplicador utilizando Full_adder
module multiplier #(
    parameter N = 4 // Ancho de los operandos y del resultado
)(
    input logic [N-1:0] a, b,
    output logic [N-1:0] result, // Solo los bits menos significativos del resultado
    output logic overflow             // Bandera de desbordamiento
);
    logic [10:0] cout;
    logic [5:0] sum;
    logic [2*N-1:0] full_result;

    assign full_result[0] = a[0] & b[0];
    
    full_adder full_adder1(b[0] & a[1], a[0] & b[1], 0, full_result[1], cout[0]);
    full_adder full_adder2(b[0] & a[2], a[1] & b[1], cout[0], sum[0], cout[1]);
    full_adder full_adder3(b[0] & a[3], a[2] & b[1], cout[1], sum[1], cout[2]);
    full_adder full_adder4(0, a[3] & b[1], cout[2], sum[2], cout[3]);
    full_adder full_adder5(sum[0], a[0] & b[2], 0, full_result[2], cout[4]);
    full_adder full_adder6(sum[1], a[1] & b[2], cout[4], sum[3], cout[5]);
    full_adder full_adder7(sum[2], a[2] & b[2], cout[5], sum[4], cout[6]);
    full_adder full_adder8(cout[3], a[3] & b[2], cout[6], sum[5], cout[7]);
    full_adder full_adder9(sum[3], a[0] & b[3], 0, full_result[3], cout[8]);
    full_adder full_adder10(sum[4], a[1] & b[3], cout[8], full_result[4], cout[9]);
    full_adder full_adder11(sum[5], a[2] & b[3], cout[9], full_result[5], cout[10]);
    full_adder full_adder12(cout[7], a[3] & b[3], cout[10], full_result[6], full_result[7]);

    // Asignar los bits menos significativos al resultado
    assign result = full_result[N-1:0];

    // Activar la bandera de desbordamiento si los bits significativos no son 0
    assign overflow = |full_result[2*N-1:N];
endmodule


// Módulo para convertir binario a BCD
module bin2bcd #(
    parameter N = 4 // Ancho de la entrada binaria
)(
    input logic [N-1:0] bin,
    output logic [7:0] bcd // 2 dígitos BCD (cada uno de 4 bits)
);
    integer i;
    always_comb begin
        bcd = 8'b0;  // Inicializa BCD en 0
        for (i = N-1; i >= 0; i = i - 1) begin
            // Añadir 3 si algún dígito es mayor o igual a 5
            if (bcd[3:0] >= 5)
                bcd[3:0] = bcd[3:0] + 3;
            if (bcd[7:4] >= 5)
                bcd[7:4] = bcd[7:4] + 3;

            // Desplazar hacia la izquierda
            bcd = {bcd[6:0], bin[i]};
        end
    end
endmodule

// Basado de https://electronics.stackexchange.com/questions/212136/multiplier-4-bit-with-verilog-using-just-full-adders