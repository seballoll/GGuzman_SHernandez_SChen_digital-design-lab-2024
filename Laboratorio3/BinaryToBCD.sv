module BinaryToBCD (
    input logic [3:0] bin,  // Entrada en binario (4 bits)
    output logic [3:0] tens,  // Decenas en BCD
    output logic [3:0] ones   // Unidades en BCD
);

    always_comb begin
        if (bin < 10) begin
            tens = 4'd0;  // Las decenas son 0
            ones = bin;   // Las unidades son el valor binario
        end
        else begin
            tens = 4'd1;  // Las decenas son 1
            ones = bin - 10;  // Las unidades son el valor binario menos 10
        end
    end

endmodule
