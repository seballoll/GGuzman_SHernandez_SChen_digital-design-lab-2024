module Victoria(
	input logic clk,
   input logic rst_n,
	input logic [17:0] matrix,
	output logic G1,
	output logic G2
	);

	
    // Lógica para verificar los bits de la matriz
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            G1 <= 1'b0;  // Inicializa g en 0
				G1 <= 1'b0;
        end
        else begin
            // Verifica si los bits matrix[1], matrix[3] y matrix[5] están activos
            if (matrix[1] && matrix[3] && matrix[5]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[7] && matrix[9] && matrix[11]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[13] && matrix[15] && matrix[17]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end 
				else if (matrix[1] && matrix[7] && matrix[13]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[3] && matrix[9] && matrix[15]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[5] && matrix[11] && matrix[17]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[5] && matrix[9] && matrix[13]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[1] && matrix[9] && matrix[17]) begin
                G1 <= 1'b1;  // Activa g si se cumple la condición
            end
				
				
				else if (matrix[0] && matrix[2] && matrix[4]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[6] && matrix[8]&&matrix[10]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[12] && matrix[14]&&matrix[16]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[0] && matrix[6]&&matrix[12]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[2] && matrix[8]&&matrix[14]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[4] && matrix[10]&&matrix[16]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[4] && matrix[8]&&matrix[12]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
				else if (matrix[0] && matrix[8]&&matrix[16]) begin
                G2 <= 1'b1;  // Activa g si se cumple la condición
            end
            else begin
                G1 <= 1'b0;  // De lo contrario, g permanece en 0
					 G2 <= 1'b0;
            end
        end
		  end
endmodule 