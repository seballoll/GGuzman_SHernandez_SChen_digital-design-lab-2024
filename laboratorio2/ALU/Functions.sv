

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
    input logic [2:0] aluOp, // Selector de operación
    output logic [N-1:0] result,
    output logic carryOut,
    output logic zero
);

    // Enumeración de operaciones
    typedef enum logic [2:0] {
        AND_OP    = 3'b000,
        OR_OP     = 3'b001,
        XOR_OP    = 3'b010,
        SLL_OP    = 3'b011, // Shift left logical
        SRL_OP    = 3'b100, // Shift right logical
        DIV_OP    = 3'b101,
        MOD_OP    = 3'b110
    } alu_ops_t;

    alu_ops_t operation;

    always_comb begin
        carryOut = 0;
        case (aluOp)
            AND_OP: result = a & b;
            OR_OP: result = a | b;
            XOR_OP: result = a ^ b;
            SLL_OP: result = a << b;
            SRL_OP: result = a >> b;
            DIV_OP: result = a / b;
            MOD_OP: result = a % b;
            default: result = 0;
        endcase
        zero = (result == 0);
    end

endmodule
