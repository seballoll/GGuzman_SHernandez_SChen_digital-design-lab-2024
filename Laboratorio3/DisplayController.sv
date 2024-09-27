module DisplayController (
    input logic [3:0] bin,       // Valor del contador en binario (4 bits)
    output logic [6:0] seg2,     // Segmentos del primer display (decenas)
    output logic [6:0] seg1      // Segmentos del segundo display (unidades)
);

    logic [3:0] tens, ones;

    // Convertir el valor binario a BCD
    BinaryToBCD bcd_conv (
        .bin(bin),
        .tens(tens),
        .ones(ones)
    );

    // Mostrar las decenas en el primer display
    HexTo7Segment display1 (
        .hex(tens),
        .seg(seg2)
    );

    // Mostrar las unidades en el segundo display
    HexTo7Segment display2 (
        .hex(ones),
        .seg(seg1)
    );

endmodule
