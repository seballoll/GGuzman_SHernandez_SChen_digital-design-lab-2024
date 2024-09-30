module MEF (
    input logic clk, rst, T, I, B, A, J1, J2, C,
    input logic finished,            // Entrada desde el TopCounter
	 input logic G1, G2,
    output logic [3:0] estado,       // Salida de estado actual
    output logic [3:0] next_state    // Salida del siguiente estado
);

    // Definir los estados de la MEF
    typedef enum logic [3:0] {
        S0 = 4'b0000, S1 = 4'b0001, S2 = 4'b0010, S3=4'b0011, S4=4'b0100,
        S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, S8=4'b1000, S9=4'b1001
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
                else if (A)
                    next_state_enum = S5;     // Cambio a S6 si J1 está en alto
					 else next_state_enum= S0;
            end
            S1: begin
                if (!I)
                    next_state_enum = S2;     // Cambio a S2 si I está en bajo
                else if (finished)            // Cambio a S2 si finished es 1
                    next_state_enum = S2;
					 else if (G1)            // Cambio a S2 si finished es 1
                    next_state_enum = S3;
						  
					 else next_state_enum= S1;
            end
            S2: begin
                if (C)
                    next_state_enum = S1;    
					 else if (G2)            
                    next_state_enum = S4;
					 else next_state_enum= S2;
            end
				S3: begin
                if (A)
                    next_state_enum = S0;     // Regreso a S1 si A está en alto
					 else next_state_enum= S3;
            end
				S4: begin
                if (A)
                    next_state_enum = S0;     // Regreso a S1 si A está en alto
					 else next_state_enum= S4;
            end
				

				S5: begin
                if (J1)
                    next_state_enum = S6;     // Cambio a S7 si I está en bajo
                else if (J2)            // Cambio a S7 si finished es 1
                    next_state_enum = S7;
					 else next_state_enum= S5;
            end
            S6: begin
                if (!I)
                    next_state_enum = S7;
					 else if (G1)
					     next_state_enum = S3;
                else if (finished)            
                    next_state_enum = S7;
					 else next_state_enum= S6;
            end
            S7: begin
                if (!B)
                    next_state_enum = S6; 
					else if (G2)
					     next_state_enum = S9;		  // Regreso a S6 si B está en bajo
                else if (finished)            // Regreso a S6 si finished es 1
                    next_state_enum = S6;
					 else  next_state_enum= S7;
            end
				S8: begin
                if (A)
                    next_state_enum = S0;     // Regreso a S1 si A está en alto
					 else next_state_enum= S8;
            end
				S9: begin
                if (A)
                    next_state_enum = S0;     // Regreso a S1 si A está en alto
					 else next_state_enum= S9;
            end
				
            default: next_state_enum = S0;
        endcase
    end

    // Lógica de salida (estado)
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            estado <= 4'b0000;
        else
            estado <= current_state;  
    end

    // Asignación del siguiente estado
    assign next_state = next_state_enum;  

endmodule
