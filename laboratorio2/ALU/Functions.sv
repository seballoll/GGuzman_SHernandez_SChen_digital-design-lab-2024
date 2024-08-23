

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
	 
	  // Bandera Z (Cero): Se activa si el resultado es 0
    always_comb begin
        zeroFlag = (andResult == 0) & (orResult == 0) & (xorResult == 0) & 
                   (sllResult == 0) & (srlResult == 0) & (divResult == 0) & 
                   (modResult == 0);
    end

    // Bandera N (Negativo): Se activa si el bit más significativo es 1 (signo negativo en operaciones con signo)
    always_comb begin
        negativeFlag = andResult[N-1] | orResult[N-1] | xorResult[N-1] |
                       sllResult[N-1] | srlResult[N-1] | divResult[N-1] |
                       modResult[N-1];
    end

endmodule

