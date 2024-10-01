module LFSR_impares (
    input logic clk,         // Reloj
    input logic rst_n,       // Reset activo bajo
    input logic [3:0] seed,  // Semilla inicial para el LFSR (número impar)
    output logic [3:0] random_out  // Número pseudoaleatorio impar de salida
);

    logic [3:0] lfsr;  // Registro del LFSR

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lfsr <= seed;  // Inicializar el LFSR con la semilla al reset
        end
        else begin
            // Desplazar el LFSR y aplicar retroalimentación XOR
            lfsr[3] <= lfsr[2];
            lfsr[2] <= lfsr[1];
            lfsr[1] <= lfsr[0];
            lfsr[0] <= lfsr[3] ^ lfsr[2];  // Retroalimentación XOR con bits 3 y 2
        end
    end

    // Forzamos el LSB a 1 para generar solo números impares
    assign random_out = {lfsr[3:1], 1'b1};

endmodule
