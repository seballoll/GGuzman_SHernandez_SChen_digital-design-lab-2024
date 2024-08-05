module Decoder (
    input  wire [3:0] bin,  // Entrada de 4 bits desde los switches
    output wire [6:0] seg1, // Display de 7 segmentos para unidades
    output wire [6:0] seg2  // Display de 7 segmentos para decenas
);

    wire [7:0] bcd;

    // Convertir BCD a 7 segmentos
    display7segmentos display1 (
        .bcd(bcd[3:0]),
        .seg(seg1)
    );

    display7segmentos display2 (
        .bcd(bcd[7:4]),
        .seg(seg2)
    );

endmodule

module display7segmentos (
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


