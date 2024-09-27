module Conversion (
    input logic clk,          // Reloj global
    input logic rst,          // Señal de reset
    output logic finished,    // Señal que indica que el contador ha llegado a 15 segundos
    output logic [6:0] seg1,  // Segmentos del primer display de 7 segmentos (decenas)
    output logic [6:0] seg2   // Segmentos del segundo display de 7 segmentos (unidades)
);

    logic [3:0] count;        // Contador de 4 bits para visualizar los segundos

    // Instanciamos el contador de 15 segundos
    TopCounter counter_inst (
        .clk(clk),
        .rst(rst),
        .finished(finished),
        .count(count)
    );

    // Instanciamos el controlador de displays BCD
    DisplayController display_inst (
        .bin(count),
        .seg1(seg1),
        .seg2(seg2)
    );

endmodule
