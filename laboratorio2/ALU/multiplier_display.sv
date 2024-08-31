// Módulo principal que integra todo
module multiplier_display #(
    parameter N = 4 // Ancho de los operandos y del resultado
)(
    input logic [N-1:0] a, b,
    output logic [6:0] seg1, seg2,
    output logic overflow // Bandera de desbordamiento
);
    logic [N-1:0] result;
    logic [7:0] bcd;

    // Instancia del multiplicador
    multiplier #(.N(N)) mult_inst (
        .a(a),
        .b(b),
        .result(result),
        .overflow(overflow)   // Conectar la bandera de desbordamiento
    );

    // Conversión de binario a BCD
    bin2bcd #(.N(N)) bcd_inst (
        .bin(result),
        .bcd(bcd)
    );

    // Decodificación BCD a 7 segmentos
    bcd_to_7seg seg1_inst (
        .bcd(bcd[3:0]),
        .seg(seg1)
    );

    bcd_to_7seg seg2_inst (
        .bcd(bcd[7:4]),
        .seg(seg2)
    );
endmodule
