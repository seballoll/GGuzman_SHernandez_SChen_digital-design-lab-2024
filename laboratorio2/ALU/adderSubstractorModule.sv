module adderSubstractorModule #(
    parameter N = 4 // Ancho de los operandos y del resultado
)(

	input logic [N-1:0] A, B,  	 // Operand A and B
	input logic Cin, Bin, 	  	 // First carry and borrow
	output logic [N-1:0] Sum, 	 // Sum result
	output logic Cout,	 		 // Sum carry
	output logic [N-1:0] Sub, 	 // Subtraction result
	output logic Bout 	       	 // Subtraction borrow
);

	wire [N:1] _C;
	wire [N:1] _B;
	
	// Instantiation of adder_1bit and subtractor_1bit
	genvar i;
	generate 
	
		for (i = 0; i < N; i = i + 1) begin : gen_loop
			oneBitAdder adder_inst(
				.A(A[i]),
				.B(B[i]),
				.Cin(i == 0 ? 1'b0 : _C[i]),
				.Sum(Sum[i]),
				.Cout(_C[i+1])
			);
			
			oneBitSubstractor subtractor_inst (
				.A(A[i]), 
				.B(B[i]),
				.Bin((i == 0) ? 1'b0 : _B[i]),
				.Sub(Sub[i]),
				.Bout(_B[i+1])
			);
		end
	endgenerate
	
	assign Cout = _C[N]; // Final carry
	

endmodule