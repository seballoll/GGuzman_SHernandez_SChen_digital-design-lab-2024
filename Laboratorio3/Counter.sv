module Counter(
    input logic clk, rst,
    output logic t0
);
    logic [26:0] cycles;  // Contador de 27 bits para contar hasta 200

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            cycles = 0;
            t0 = 0;
        end
        else begin
            if (cycles == 50000000 - 1 ) begin
                cycles = 0;
                t0 = 1;  // Activa t0 cuando llega a 200
            end
            else begin
                cycles = cycles + 1;
                t0 = 0;  // t0 se mantiene en 0 mientras no llega a 200
            end
        end
    end
endmodule
