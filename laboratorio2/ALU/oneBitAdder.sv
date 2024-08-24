module oneBitAdder (
    input logic A,          // Entrada A
    input logic B,          // Entrada B
    input logic Cin,        // Carry in
    output logic S,         // Suma
    output logic Cout       // Carry out
);

    // Lógica del sumador completo de 1 bit
    assign Sum = A ^ B ^ Cin;               // Suma
    assign Cout = (A & B) | (Cin & A) | (Cin & B);  // Carry out

endmodule