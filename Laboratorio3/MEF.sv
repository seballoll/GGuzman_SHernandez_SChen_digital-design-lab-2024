module MEF (
    input logic clk, rst, T, I, B, A, J1,
    input logic finished,            // Entrada desde el TopCounter
    output logic [3:0] estado,       // Salida de estado actual
    output logic [3:0] next_state    // Salida del siguiente estado
);

    // Definir los estados de la MEF
    typedef enum logic [3:0] {
        S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010,
        S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111
    } state_t;

    state_t current_state, next_state_enum;  // Estados actuales y siguientes

    // Actualización de estado
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state_enum;
    end

    // Lógica de transición de estados
    always_comb begin
        next_state_enum = current_state;  // Mantener el estado por defecto
        case (current_state)
            S0: begin
                if (T)
                    next_state_enum = S1;     // Cambio a S1 si T está en alto
                else if (J1)
                    next_state_enum = S6;     // Cambio a S6 si J1 está en alto
            end
            S1: begin
                if (!I)
                    next_state_enum = S2;     // Cambio a S2 si I está en bajo
                else if (finished)            // Cambio a S2 si finished es 1
                    next_state_enum = S2;
            end
            S2: begin
                if (A)
                    next_state_enum = S1;     // Regreso a S1 si A está en alto
            end
            S6: begin
                if (!I)
                    next_state_enum = S7;     // Cambio a S7 si I está en bajo
                else if (finished)            // Cambio a S7 si finished es 1
                    next_state_enum = S7;
            end
            S7: begin
                if (!B)
                    next_state_enum = S6;     // Regreso a S6 si B está en bajo
                else if (finished)            // Regreso a S6 si finished es 1
                    next_state_enum = S6;
            end
            default: next_state_enum = S0;
        endcase
    end

    // Lógica de salida (estado)
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            estado <= 4'b0000;
        else
            estado <= logic'(current_state);  // Casting explícito a logic[3:0]
    end

    // Asignación del siguiente estado
    assign next_state = logic'(next_state_enum);  // Casting explícito para la salida

endmodule
