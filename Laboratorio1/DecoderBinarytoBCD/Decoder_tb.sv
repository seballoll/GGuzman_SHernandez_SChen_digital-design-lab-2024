module Decoder_tb;
    reg [3:0] bin;         // Simulación de los switches de entrada
    wire [6:0] seg1;       // Salida del display de 7 segmentos para las unidades
    wire [6:0] seg2;       // Salida del display de 7 segmentos para las decenas

    // Instanciar 
    Decoder test (
        .bin(bin),
        .seg1(seg1),
        .seg2(seg2)
    );

    // Procedimiento inicial
    initial begin
        // Monitor para mostrar los resultados en la consola
        $monitor("Time = %0t | bin = %b | seg1 = %b | seg2 = %b", $time, bin, seg1, seg2);

        // Probar varios valores
        bin = 4'b0000; #10; // 0
        bin = 4'b0001; #10; // 1
        bin = 4'b0010; #10; // 2
        bin = 4'b0011; #10; // 3
        bin = 4'b0100; #10; // 4
        bin = 4'b0101; #10; // 5
        bin = 4'b0110; #10; // 6
        bin = 4'b0111; #10; // 7
        bin = 4'b1000; #10; // 8
        bin = 4'b1001; #10; // 9
        bin = 4'b1010; #10; // 10
        bin = 4'b1011; #10; // 11
        bin = 4'b1100; #10; // 12
        bin = 4'b1101; #10; // 13
        bin = 4'b1110; #10; // 14
        bin = 4'b1111; #10; // 15

        $finish; // Terminar la simulación
    end
endmodule 