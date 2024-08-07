module Decoder (
    input  wire [3:0] bin,  // Entrada de 4 bits desde los switches
    output wire [6:0] seg1, // Display de 7 segmentos para unidades
    output wire [6:0] seg2  // Display de 7 segmentos para decenas
);

    wire [7:0] bcd;

    // Instanciar el módulo converter
    converter decoder (
        .bin(bin),
        .bcd(bcd)
    );

    display7segmentos display1 (
        .bcd(bcd[3:0]),
        .seg(seg1)
    );

    display7segmentos display2 (
        .bcd(bcd[7:4]),
        .seg(seg2)
    );

endmodule

module display7segmentos (    //Interpretador para el 7 segmentos
    input wire [3:0] bcd,
    output reg [6:0] seg
);
    always @(*) begin
        case (bcd)
            4'b0000: seg = 7'b1000000; // 0
            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1001: seg = 7'b0010000; // 9
            default: seg = 7'b1111111; // Display en blanco
        endcase
    end
endmodule

module converter (
    input  wire [3:0] bin,  // Entrada de 4 bits binarios
    output reg  [7:0] bcd   // Salida de 8 bits BCD (dos dígitos BCD)
);

    reg [7:0] bcd_temp;  //Registro temporal 8bits
    reg [3:0] i; //Iteracion para analizar los 4 bits

    always @(bin) begin  //Algoritmo para interpretar los binarios y pasarlos a BCD
        bcd_temp = 0;
        bcd = 0;

        for (i = 0; i < 4; i = i + 1) begin
            bcd_temp = {bcd_temp[6:0], bin[3 - i]};
            
            if (i < 3 && bcd_temp[3:0] > 4) 
                bcd_temp[3:0] = bcd_temp[3:0] + 3;
            if (i < 3 && bcd_temp[7:4] > 4) 
                bcd_temp[7:4] = bcd_temp[7:4] + 3;
        end
        
        bcd = bcd_temp;
    end

endmodule


//
