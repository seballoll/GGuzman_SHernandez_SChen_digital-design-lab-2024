

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

module ALU #(parameter N = 8)(
    input logic [N-1:0] a, b,
    output logic [N-1:0] andResult,
    output logic [N-1:0] orResult,
    output logic [N-1:0] xorResult,
    output logic [N-1:0] sllResult,  // Shift left logical
    output logic [N-1:0] srlResult,  // Shift right logical
    output logic [N-1:0] divResult,
    output logic [N-1:0] modResult
);

    // Operaciones
    assign andResult = a & b;
    assign orResult  = a | b;
    assign xorResult = a ^ b;
    assign sllResult = a << b;
    assign srlResult = a >> b;
    assign divResult = a / b;
    assign modResult = a % b;

endmodule

