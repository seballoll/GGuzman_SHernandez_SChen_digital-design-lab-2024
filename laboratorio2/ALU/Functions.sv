

module FullAdderModule #(parameter N) (
    input logic A,          // Entrada A
    input logic B,          // Entrada B
    input logic Cin,        // Carry in
    output logic S,         // Suma
    output logic Cout       // Carry out
);

    // Lógica del sumador completo de 1 bit
    assign S = A ^ B ^ Cin;               // Suma
    assign Cout = (A & B) | (Cin & A) | (Cin & B);  // Carry out

endmodule


module FullAdderSubstractorModule #(parameter N) (
    input logic A,          // Entrada A
    input logic B,          // Entrada B
    input logic Sel,        // seleccion de operacion
    output logic R,         // Resta
    output logic Cout_borrow       // Carry out con borrow
);

    // Lógica del sumador completo de 1 bit
	 
	 logic Inv = B ^ Sel;
    assign S = A ^ Inv ^ Sel;               // Resta
    assign Cout = (A & Inv) | (Sel & A) | (Sel & Inv);  // Carry out

endmodule