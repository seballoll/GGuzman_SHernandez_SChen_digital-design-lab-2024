module matrixControl (
    input  logic        clk,         // Clock signal
    input  logic        rst_n,       // Active low reset signal
    input  logic        I,  // Button to select matrix position (8 to 0)
    input  logic        W, // Button to confirm and set selected position to 1
	 input  logic        finished,
	 input  logic        B,
	 input  logic        Z,
    input  logic [17:0]  matrix_in,   // Input 9-bit matrix
	 input logic [3:0] current_state,
    output logic [17:0]  matrix_out,  // Output 9-bit matrix with modified value
    output logic        load,       // Load signal to indicate a change
	 output logic [5:0]  indexOut
);

    logic [5:0] index1;  // 4-bit index to count from 8 to 0 (positions in the 9-bit matrix)
	 logic [5:0] index2;
    logic [17:0] temp_matrix; // Temporary matrix to store the modified values
	 logic [5:0] random_index;

    // Button select logic to cycle through matrix positions
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            index1 <= 5'd17; // Start at the 8th bit (top-left) when reset
				index2 <= 5'd16;
        end
        else if (!W) begin
            if (index1 == 5'd1)
                index1 <= 5'd17;  // Loop back to 8 after reaching 0
            else
                index1 <= index1 - 5'd2; // Move to the next position
        end
		  else if (!Z) begin
            if (index2 == 5'd0)
                index2 <= 5'd16;  // Loop back to 8 after reaching 0
            else
                index2 <= index2 - 5'd2; // Move to the next position
        end

		      
    end

    // Button confirm logic to modify the matrix
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            temp_matrix <= matrix_in; // Initialize temp_matrix with input matrix
            load <= 1'b0;             // No load when reset
				
        end
		  
			else if (!I	&& (current_state == 4'b0001)) 
			begin
			 // Verifica si el bit en la posición 'index' ya es 1
			 if (!(matrix_in[index1])&&!(matrix_in[index1-1])) begin
				  temp_matrix <= matrix_in | (18'b1 << index1); // Pone el bit correspondiente a 1 si no lo es
				  load <= 1'b1; // Indica que se ha hecho un cambio
				   
				end
			 else begin
				  load <= 1'b0; // No hay cambio, ya que el bit en 'index' ya es 1
				end
			end
			
			else if (!B	&& (current_state == 4'b0111)) 
			begin
			 // Verifica si el bit en la posición 'index' ya es 1
			 if (!(matrix_in[index2])&&!(matrix_in[index2+1])) begin
				  temp_matrix <= matrix_in | (18'b1 << index2); // Pone el bit correspondiente a 1 si no lo es
				  load <= 1'b1; // Indica que se ha hecho un cambio
				   
				end
			 else begin
				  load <= 1'b0; // No hay cambio, ya que el bit en 'index' ya es 1
				end
			end
			
		  
			else if (!I && (current_state == 4'b0110)) begin
			 // Verifica si el bit en la posición 'index' ya es 1
			 if  (!(matrix_in[index1])&&!(matrix_in[index1-1])) begin
				  temp_matrix <= matrix_in | (18'b1 << index1); // Pone el bit correspondiente a 1 si no lo es
				  load <= 1'b1; // Indica que se ha hecho un cambio
				 
				end
			 else begin
				  load <= 1'b0; // No hay cambio, ya que el bit en 'index' ya es 1
				end
			end
//			else if (finished) begin
//							if (!matrix_in[index1+random_index]&&(current_state==4'b0001 | current_state==4'b0110)) begin
//								 temp_matrix <= matrix_in | (9'b1 << random_index); // Place a 1 in the available position
//								 
//								 load <= 1'b1; // Indicate that a change has been made
//							end
//							else if (!matrix_in[random_index]&&(current_state==4'b0111)) begin
//								 temp_matrix <= matrix_in | (9'b1 << random_index); // Place a 1 in the available position
//								 
//								 load <= 1'b1; // Indicate that a change has been made
//							end
//					   
//					  else begin
//							load <= 1'b0; // No load when confirm button is not pressed
//					  end
//					 
//					 end

		  
        else begin
            load <= 1'b0; // No load when confirm button is not pressed
        end
    end

    // Assign the modified matrix to the output
    assign matrix_out = temp_matrix;

endmodule
