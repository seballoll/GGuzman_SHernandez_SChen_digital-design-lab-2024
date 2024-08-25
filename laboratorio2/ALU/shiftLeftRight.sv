module shift_left_right #(parameter N = 4, parameter Direction = 1'b0) ( // Direction 1'b1 for left and 1'b0 for right
	input logic [N-1:0] Number,
	output logic [N-1:0] Result
);
									
	
		
		always @(*) begin
for(int i = 1; i<=N-2; i++) begin // Loop that shifts the input.
			Result[i] = (Number[i-1] & Direction) || (Number[i+1] & ~Direction);
		end 

		// Shift for the first and last bit of the input
		Result[0] = Number[1] & ~Direction;
		Result[N-1] = Number[N-2] & Direction;

	
		end
		
endmodule 